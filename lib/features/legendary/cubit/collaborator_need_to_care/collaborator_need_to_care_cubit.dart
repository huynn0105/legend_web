import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/extension/list_extension.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_controller.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import 'package:legend_mfast/models/collaborator/collaborator_care_filter_model.dart';

import '../../../../common/enum/collaborator/collaborator_status.dart';
import '../../../../common/utils/debounce_util.dart';
import '../../../../models/base_model.dart';
import '../../../../models/collaborator/collaborator_care_list_model.dart';
import '../../../../models/general_object.dart';
import '../../../../services/api/legendary/payload/legendary_collaborators_need_care_by_filter_payload.dart';

part 'collaborator_need_to_care_state.dart';

class CollaboratorNeedToCareCubit extends Cubit<CollaboratorNeedToCareState> {
  CollaboratorNeedToCareCubit() : super(const CollaboratorNeedToCareState());

  final _repository = LegendaryRepository();

  LegendaryCollaboratorsNeedCareByFilterPayload _payload = const LegendaryCollaboratorsNeedCareByFilterPayload();

  fetchData(CollaboratorStatus? collaboratorStatus) async {
    final option = GeneralObject(
      code: collaboratorStatus?.name,
      name: collaboratorStatus?.title,
    );
    emit(state.copyWith(selectedTab: option));
    _updatePayload(tab: option.code);
    await Future.wait([
      _getCollaboratorFilter(),
    ]);
  }

  Future<void> _getCollaboratorFilter() async {
    BaseModel<CollaboratorCareFilterModel> result = await _repository.getCollaboratorCareFilter();
    CollaboratorCareFilterModel? collaboratorFilter = result.data;
    _initPayload(collaboratorFilter);
    emit(state.copyWith(collaboratorFilter: collaboratorFilter));
    getAllCollaboratorsByFilter();
  }

  getAllCollaboratorsByFilter() async {
    Future.wait([
      getCollaboratorsByFilter(tabCode: CollaboratorStatus.working.name),
      getCollaboratorsByFilter(tabCode: CollaboratorStatus.follow.name),
      getCollaboratorsByFilter(tabCode: CollaboratorStatus.can_leave.name),
      getCollaboratorsByFilter(tabCode: CollaboratorStatus.can_remove.name),
      getCollaboratorsByFilter(tabCode: CollaboratorStatus.departed.name),
    ]);
  }

  _initPayload(CollaboratorCareFilterModel? collaboratorFilter) {
    GeneralObject? grade = collaboratorFilter?.grade?.getFirst();
    List<GeneralObject> selectedGrades = grade != null ? [grade] : [];
    _updatePayload(
      grade: selectedGrades.map((e) => e.code ?? '').toList(),
      page: 1,
    );
    emit(state.copyWith(
      selectedGrades: selectedGrades,
    ));
  }

  Future<void> getCollaboratorsByFilter({String? tabCode, bool showLoading = true, bool loadMore = false}) async {
    if (tabCode == null) {
      tabCode == state.selectedTab?.code;
    }
    if (showLoading) {
      emit(state.copyWith(
        statusWorking: tabCode == CollaboratorStatus.working.name ? BlocStatus.loading : null,
        statusFollow: tabCode == CollaboratorStatus.follow.name ? BlocStatus.loading : null,
        statusCanLeave: tabCode == CollaboratorStatus.can_leave.name ? BlocStatus.loading : null,
        statusCanRemove: tabCode == CollaboratorStatus.can_remove.name ? BlocStatus.loading : null,
        statusDeparted: tabCode == CollaboratorStatus.departed.name ? BlocStatus.loading : null,
      ));
    }
    _updatePayload(page: loadMore ? _payload.page + 1 : 1, tab: tabCode);
    final result = await _repository.getCollaboratorsNeedCareByFilter(
      payload: _payload,
    );

    if (result.status) {
      List<CollaboratorCareModel> currentData = _getCurrentList(tabCode);
      final data = loadMore ? [...currentData, ...?result.data?.data] : result.data?.data;
      final total = result.data?.total;
      emit(state.copyWith(
        statusWorking: tabCode == CollaboratorStatus.working.name ? BlocStatus.success : null,
        statusFollow: tabCode == CollaboratorStatus.follow.name ? BlocStatus.success : null,
        statusCanLeave: tabCode == CollaboratorStatus.can_leave.name ? BlocStatus.success : null,
        statusCanRemove: tabCode == CollaboratorStatus.can_remove.name ? BlocStatus.success : null,
        statusDeparted: tabCode == CollaboratorStatus.departed.name ? BlocStatus.success : null,
        dataUserWorking: tabCode == CollaboratorStatus.working.name ? data : null,
        dataUserFollow: tabCode == CollaboratorStatus.follow.name ? data : null,
        dataUserCanLeave: tabCode == CollaboratorStatus.can_leave.name ? data : null,
        dataUserCanRemove: tabCode == CollaboratorStatus.can_remove.name ? data : null,
        dataUserDeparted: tabCode == CollaboratorStatus.departed.name ? data : null,
        totalUserWorking: tabCode == CollaboratorStatus.working.name ? total : null,
        totalUserFollow: tabCode == CollaboratorStatus.follow.name ? total : null,
        totalUserCanLeave: tabCode == CollaboratorStatus.can_leave.name ? total : null,
        totalUserCanRemove: tabCode == CollaboratorStatus.can_remove.name ? total : null,
        totalUserDeparted: tabCode == CollaboratorStatus.departed.name ? total : null,
      ));
    } else {
      emit(state.copyWith(
        statusWorking: tabCode == CollaboratorStatus.working.name ? BlocStatus.failure : null,
        statusFollow: tabCode == CollaboratorStatus.follow.name ? BlocStatus.failure : null,
        statusCanLeave: tabCode == CollaboratorStatus.can_leave.name ? BlocStatus.failure : null,
        statusCanRemove: tabCode == CollaboratorStatus.can_remove.name ? BlocStatus.failure : null,
        statusDeparted: tabCode == CollaboratorStatus.departed.name ? BlocStatus.failure : null,
      ));
    }
  }

  List<CollaboratorCareModel> _getCurrentList(String? tabCode) {
    if (tabCode == CollaboratorStatus.working.name) {
      return state.dataUserWorking;
    }
    if (tabCode == CollaboratorStatus.follow.name) {
      return state.dataUserFollow;
    }
    if (tabCode == CollaboratorStatus.can_leave.name) {
      return state.dataUserCanLeave;
    }
    if (tabCode == CollaboratorStatus.can_remove.name) {
      return state.dataUserCanRemove;
    }
    if (tabCode == CollaboratorStatus.departed.name) {
      return state.dataUserDeparted;
    }
    return [];
  }

  refreshData() async {
    await getCollaboratorsByFilter(showLoading: false);
  }

  loadmoreData() async {
    await getCollaboratorsByFilter(showLoading: false, loadMore: true);
    if (state.selectedTab?.code == CollaboratorStatus.working.name) {
      return state.totalUserWorking != state.dataUserWorking.length;
    }
    if (state.selectedTab?.code == CollaboratorStatus.follow.name) {
      return state.totalUserFollow != state.dataUserFollow.length;
    }
    if (state.selectedTab?.code == CollaboratorStatus.can_leave.name) {
      return state.totalUserCanLeave != state.dataUserCanLeave.length;
    }
    if (state.selectedTab?.code == CollaboratorStatus.can_remove.name) {
      return state.totalUserCanRemove != state.dataUserCanRemove.length;
    }
    if (state.selectedTab?.code == CollaboratorStatus.departed.name) {
      return state.totalUserDeparted != state.dataUserDeparted.length;
    }
    return false;
  }

  selectTabOption(GeneralObject option) {
    emit(state.copyWith(selectedTab: option));
    _updatePayload(tab: option.code);
  }

  selectLevelOptions(List<GeneralObject> options) {
    emit(state.copyWith(selectedLevels: options));
    _updatePayload(level: options.map((e) => e.code ?? '').toList());
    getAllCollaboratorsByFilter();
  }

  selectGradeOptions(List<GeneralObject> options) {
    emit(state.copyWith(selectedGrades: options));
    _updatePayload(grade: options.map((e) => e.code ?? '').toList());
    getAllCollaboratorsByFilter();
  }

  _updatePayload({
    List<String>? grade,
    List<String>? level,
    String? tab,
    int? page,
  }) {
    _payload = _payload.copyWith(
      grade: grade,
      level: level,
      type: tab,
      page: page,
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/extension/list_extension.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_controller.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import 'package:legend_mfast/models/collaborator/collaborator_status_model.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_collaborator_filter_payload.dart';

import '../../../../common/utils/debounce_util.dart';
import '../../../../models/base_model.dart';
import '../../../../models/collaborator/collaborator_filter_model.dart';
import '../../../../models/collaborator/collaborator_model.dart';
import '../../../../models/general_object.dart';
import '../../../../services/api/legendary/payload/legendary_collaborators_by_filter_payload.dart';

part 'legendary_collaborator_state.dart';

class LegendaryCollaboratorCubit extends Cubit<LegendaryCollaboratorState> {
  LegendaryCollaboratorCubit() : super(const LegendaryCollaboratorState());

  final _repository = LegendaryRepository();

  final chartController = DonutChartController();

  LegendaryCollaboratorsByFilterPayload _payload = const LegendaryCollaboratorsByFilterPayload();

  final DebounceUtil debounce = DebounceUtil(milliseconds: 300);

  fetchData({bool showLoading = true, String? rank}) async {
    if (showLoading) {
      emit(state.copyWith(status: BlocStatus.loading));
    }
    emit(state.copyWith(rank: rank));
    await Future.wait([
      _getCollaboratorStatus(),
      _getCollaboratorFilter(),
    ]);
  }

  Future<void> _getCollaboratorStatus() async {
    BaseModel<CollaboratorStatusModel> result = await _repository.getAllCollaboratorStatus();
    emit(state.copyWith(collaboratorStatus: result.data));
  }

  void updateCollaboratorPending(int userPending) {
    emit(state.copyWith(
      userPending: userPending,
    ));
  }

  Future<void> _getCollaboratorFilter() async {
    String? userId = AppData.instance.userID;
    BaseModel<CollaboratorFilterModel> result = await _repository.getCollaboratorFilter(
      payload: LegendaryCollaboratorFilterPayload(
        userID: userId,
        rank: state.rank,
      ),
    );
    CollaboratorFilterModel? collaboratorFilter = result.data;
    _initPayload(collaboratorFilter);
    emit(state.copyWith(
      collaboratorFilter: collaboratorFilter,
      userPending: collaboratorFilter?.userPending,
    ));
    await getCollaboratorsByFilter();
  }

  _initPayload(CollaboratorFilterModel? collaboratorFilter) {
    String? userId = AppData.instance.userID;
    GeneralObject? level = collaboratorFilter?.level?.getFirst();
    List<GeneralObject> selectedLevels = level != null ? [level] : [];
    GeneralObject? selectedSort = collaboratorFilter?.sort?.getFirst();
    GeneralObject? selectedWork = collaboratorFilter?.work?.getFirst();
    GeneralObject? selectedTab = collaboratorFilter?.tabs?.getFirst();
    String month = DateTimeUtil.getString(DateTime.now(), format: DateTimeFormat.yyyyMM);
    _updatePayload(
      level: selectedLevels.map((e) => e.code ?? '').toList(),
      sort: selectedSort?.code,
      work: selectedWork?.code,
      tab: selectedTab?.code,
      keyword: '',
      month: month,
      userID: userId,
      page: 1,
    );
    emit(state.copyWith(
      selectedLevels: selectedLevels,
      selectedSort: selectedSort,
      selectedWork: selectedWork,
      selectedTab: selectedTab,
    ));
  }

  Future<void> getCollaboratorsByFilter({bool showLoading = true, bool loadMore = false}) async {
    if (showLoading) {
      emit(state.copyWith(
        status: BlocStatus.loading,
      ));
    }
    _updatePayload(page: loadMore ? _payload.page + 1 : 1);
    final result = await _repository.getCollaboratorsByFilter(
      payload: _payload,
    );

    if (result.status) {
      final data = loadMore ? [...state.data, ...?result.data] : result.data;
      emit(state.copyWith(
        status: BlocStatus.success,
        data: data,
      ));
    } else {
      emit(state.copyWith(
        status: BlocStatus.failure,
      ));
    }
  }

  loadmoreData() async {
    final length = state.data.length;
    await getCollaboratorsByFilter(showLoading: false, loadMore: true);
    return length != state.data.length;
  }

  searchCollaborator(String text) {
    debounce.run(() {
      _updatePayload(keyword: text);
      getCollaboratorsByFilter();
    });
  }

  selectSortOption(GeneralObject option) {
    emit(state.copyWith(selectedSort: option));
    _updatePayload(sort: option.code);
    getCollaboratorsByFilter();
  }

  selectWorkOption(GeneralObject option) {
    emit(state.copyWith(selectedWork: option));
    _updatePayload(work: option.code);
    getCollaboratorsByFilter();
  }

  selectTabOption(GeneralObject option) {
    emit(state.copyWith(selectedTab: option));
    _updatePayload(tab: option.code);
    getCollaboratorsByFilter();
  }

  selectLevelOptions(List<GeneralObject> options) {
    emit(state.copyWith(selectedLevels: options));
    _updatePayload(level: options.map((e) => e.code ?? '').toList());
    getCollaboratorsByFilter();
  }

  _updatePayload({
    List<String>? level,
    String? sort,
    String? work,
    String? tab,
    String? keyword,
    String? month,
    String? userID,
    int? page,
  }) {
    _payload = _payload.copyWith(
      level: level,
      sort: sort,
      work: work,
      tabs: tab,
      keyword: keyword,
      month: month,
      userID: userID,
      page: page,
    );
  }

  clearData() {
    _payload = const LegendaryCollaboratorsByFilterPayload();
    emit(const LegendaryCollaboratorState());
  }

  @override
  Future<void> close() {
    debounce.cancel();
    return super.close();
  }
}

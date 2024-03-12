import 'package:bloc/bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';
import 'package:legend_mfast/common/extension/list_extension.dart';
import 'package:legend_mfast/common/utils/color_util.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_controller.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_data.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_collaborator_chart_payload.dart';

import '../../../../models/legendary/legendary_collaborator_chart_model.dart';

part 'legendary_collaborator_chart_state.dart';

class LegendaryCollaboratorChartCubit extends Cubit<LegendaryCollaboratorChartState> {
  LegendaryCollaboratorChartCubit() : super(const LegendaryCollaboratorChartState());

  final _repository = LegendaryRepository();

  final chartController = DonutChartController();

  LegendaryCollaboratorChartPayload _payload = LegendaryCollaboratorChartPayload();

  fetchData({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(
        status: BlocStatus.loading,
      ));
    }

    final result = await _repository.getLegendaryCollaboratorChart(
      payload: _payload,
    );

    await chartController.delay();

    if (result.status) {
      final data = result.data;

      final tabFilters = data?.filter?.map((e) => DataWrapper(id: e.id, value: e.title)).toList() ?? [];
      final selectedTabFilter = state.selectedTabFilter == null ? tabFilters.getFirst() : null;
      updatePayloadTabFilter(tab: selectedTabFilter?.id);

      final levelFilters = data?.filterLevel?.map((e) => DataWrapper(id: e.id, value: e.title)).toList() ?? [];
      final selectedLevelFilter = state.selectedLevelFilter == null ? levelFilters.getFirst() : null;
      updatePayloadLevelFilter(level: selectedLevelFilter?.id);

      final typeFilters = data?.filterType?.map((e) => DataWrapper(id: e.id, value: e.title)).toList() ?? [];
      final selectedTypeFilter = state.selectedTypeFilter == null ? typeFilters.getFirst() : null;
      updatePayloadTypeFilter(type: selectedTypeFilter?.id);

      ///
      emit(state.copyWith(
        status: BlocStatus.success,
        data: data,
        tabFilters: tabFilters,
        selectedTabFilter: selectedTabFilter,
        levelFilters: levelFilters,
        selectedLevelFilter: selectedLevelFilter,
        typeFilters: typeFilters,
        selectedTypeFilter: selectedTypeFilter,
      ));
    } else {
      emit(state.copyWith(
        status: BlocStatus.failure,
      ));
    }
  }

  DonutChartData getDonutChartData() {
    final data = state.data?.collaborators?.data?.collaboratorList ?? [];
    return DonutChartData.success(
      sections: data.map(
        (e) {
          return DonutChartSectionData(
            value: (e.wallet ?? 0.0).toDouble(),
            percent: (e.currentGrowth ?? 0.0).round().toDouble(),
            label: e.name ?? '',
            unit: 'người',
            color: ColorUtil.fromHex(e.background ?? ''),
            legendData: DonutChartLegendSectionData(
              growthValue: e.salesGrowth ?? 0,
              growthStatus: e.statusGrowth ?? '',
            ),
          );
        },
      ).toList(),
    );
  }

  selectTabFilter(DataWrapper value) {
    updatePayloadTabFilter(tab: value.id);
    emit(state.copyWith(
      selectedTabFilter: value,
    ));
    fetchData();
  }

  selectLevelFilter(DataWrapper value) {
    updatePayloadLevelFilter(level: value.id);
    emit(state.copyWith(
      selectedLevelFilter: value,
    ));
    fetchData();
  }

  selectTypeFilter(DataWrapper value) {
    updatePayloadTypeFilter(type: value.id);
    emit(state.copyWith(
      selectedTypeFilter: value,
    ));
    fetchData();
  }

  _updatePayload({
    String? rank,
    String? month,
    String? tab,
    String? level,
    String? type,
    String? userID,
  }) {
    _payload = _payload.copyWith(
      rank: rank,
      month: month,
      tab: tab,
      level: level,
      type: type,
      userID: userID,
    );
  }

  updatePayloadUserID({
    String? userID,
  }) {
    _updatePayload(
      userID: userID,
    );
  }

  updatePayloadTabFilter({String? tab}) {
    _updatePayload(
      tab: tab,
    );
  }

  updatePayloadLevelFilter({String? level}) {
    _updatePayload(
      level: level,
    );
  }

  updatePayloadTypeFilter({String? type}) {
    _updatePayload(
      type: type,
    );
  }

  updatePayloadRank({String? rank}) {
    _updatePayload(
      rank: rank,
    );
  }

  updatePayloadMonth({
    String? month,
    DateTime? date,
  }) {
    if (month != null) {
      _updatePayload(month: month);
      return;
    }
    if (date != null) {
      final formatDate = DateTimeUtil.getString(
        date,
        format: DateTimeFormat.yyyy_MM,
      );
      _updatePayload(month: formatDate);
      return;
    }
  }

  @override
  Future<void> close() {
    chartController.dispose();
    return super.close();
  }
}

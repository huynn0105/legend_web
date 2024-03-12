import 'package:bloc/bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';
import 'package:legend_mfast/common/extension/list_extension.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_controller.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_data.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_helper.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import '../../../../common/utils/color_util.dart';
import '../../../../models/legendary/legendary_activity_chart_model.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_activity_chart_payload.dart';

part 'legendary_activity_chart_state.dart';

class LegendaryActivityChartCubit extends Cubit<LegendaryActivityChartState> {
  LegendaryActivityChartCubit() : super(const LegendaryActivityChartState());

  final _repository = LegendaryRepository();

  final chartController = DonutChartController();

  LegendaryActivityChartPayload _payload = LegendaryActivityChartPayload();

  fetchData({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(
        status: BlocStatus.loading,
      ));
    }

    final result = await _repository.getLegendaryActivityChart(
      payload: _payload,
    );

    await chartController.delay();

    if (result.status) {
      final data = result.data;

      final filters = data?.filter?.map((e) => DataWrapper(id: e.id, value: e.title)).toList() ?? [];
      final selectedFilter = state.selectedTabFilter == null ? filters.getFirst() : null;
      updatePayloadType(type: selectedFilter?.id);

      ///
      emit(state.copyWith(
        status: BlocStatus.success,
        data: data,
        tabFilters: filters,
        selectedTabFilter: selectedFilter,
      ));
    } else {
      emit(state.copyWith(
        status: BlocStatus.failure,
      ));
    }
  }

  DonutChartData getDonutChartData() {
    final data = state.data?.list ?? [];
    return DonutChartData.success(
      sections: data.map(
        (e) {
          return DonutChartSectionData(
            value: (e.numOfType ?? 0.0).toDouble(),
            percent: (e.percentage ?? 0.0).round().toDouble(),
            label: e.typeName ?? '',
            unit: 'hồ sơ',
            color: ColorUtil.fromHex(e.background ?? ''),
            legendData: DonutChartLegendSectionData(
              growthValue: e.percentGrowth ?? 0,
              growthStatus:
                  (e.percentGrowth ?? 0) < 0 ? DonutLegendGrowthStatus.down.name : DonutLegendGrowthStatus.up.name,
            ),
          );
        },
      ).toList(),
    );
  }

  selectTabFilter(DataWrapper value) {
    updatePayloadType(type: value.id);
    emit(state.copyWith(
      selectedTabFilter: value,
    ));
    fetchData();
  }

  _updatePayload({
    String? type,
    String? month,
    String? userID,
  }) {
    _payload = _payload.copyWith(
      type: type,
      month: month,
      userID: userID,
    );
  }

  updatePayloadUserID({String? userID}) {
    _updatePayload(
      userID: userID,
    );
  }

  updatePayloadType({String? type}) {
    _updatePayload(
      type: type,
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

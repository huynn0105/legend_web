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
import 'package:legend_mfast/services/api/legendary/payload/legendary_experience_chart_payload.dart';

import '../../../../models/legendary/legendary_experience_chart_model.dart';

part 'legendary_experience_chart_state.dart';

class LegendaryExperienceChartCubit extends Cubit<LegendaryExperienceChartState> {
  LegendaryExperienceChartCubit() : super(const LegendaryExperienceChartState());

  final _repository = LegendaryRepository();

  final chartController = DonutChartController();

  LegendaryExperienceChartPayload _payload = LegendaryExperienceChartPayload();

  fetchData({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(
        status: BlocStatus.loading,
      ));
    }

    final result = await _repository.getLegendaryExperienceChart(
      payload: _payload,
    );

    await chartController.delay();

    if (result.status) {
      final data = result.data;

      final tabFilters = data?.filter?.map((e) => DataWrapper(id: e.id, value: e.title)).toList() ?? [];
      final selectedTabFilter = state.selectedTabFilter == null ? tabFilters.getFirst() : null;
      updatePayloadDirectSale(directSales: selectedTabFilter?.id);

      ///
      emit(state.copyWith(
        status: BlocStatus.success,
        data: data,
        tabFilters: tabFilters,
        selectedTabFilter: selectedTabFilter,
      ));
    } else {
      emit(state.copyWith(
        status: BlocStatus.failure,
      ));
    }
  }

  DonutChartData getDonutChartData() {
    final data = state.data?.sales?.salesList ?? [];
    return DonutChartData.success(
      sections: data.map(
        (e) {
          return DonutChartSectionData(
            value: (e.salesPoint ?? 0.0).toDouble(),
            percent: (e.currentGrowth ?? 0.0).round().toDouble(),
            label: e.name ?? '',
            unit: 'điểm',
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
    updatePayloadDirectSale(directSales: value.id);
    emit(state.copyWith(
      selectedTabFilter: value,
    ));
    fetchData();
  }

  _updatePayload({
    String? directSales,
    String? month,
    String? userID,
  }) {
    _payload = _payload.copyWith(
      directSales: directSales,
      month: month,
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

  updatePayloadDirectSale({
    String? directSales,
  }) {
    _updatePayload(
      directSales: directSales,
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

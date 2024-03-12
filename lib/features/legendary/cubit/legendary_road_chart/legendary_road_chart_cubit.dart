import 'package:bloc/bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import '../../../../models/legendary/legendary_road_chart_model.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_road_chart_payload.dart';

part 'legendary_road_chart_state.dart';

class LegendaryRoadChartCubit extends Cubit<LegendaryRoadChartState> {
  LegendaryRoadChartCubit() : super(const LegendaryRoadChartState());

  final _repository = LegendaryRepository();

  LegendaryRoadChartPayload _payload = LegendaryRoadChartPayload();

  fetchData({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(
        status: BlocStatus.loading,
      ));
    }

    final result = await _repository.getLegendaryRoadChart(
      payload: _payload,
    );

    if (result.status) {
      final data = result.data;
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

  _updatePayload({
    String? type,
    String? month,
    String? userID,
  }) {
    _payload = _payload.copyWith(
      userID: userID,
      month: month,
    );
  }

  updatePayloadUserID({
    String? userID,
  }) {
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
}

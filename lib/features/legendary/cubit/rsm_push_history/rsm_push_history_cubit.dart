import 'package:bloc/bloc.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';
import 'package:legend_mfast/common/utils/format_util.dart';
import 'package:legend_mfast/models/base_model.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';

import '../../../../models/collaborator/collaborator_rsm_push_log_model.dart';

part 'rsm_push_history_state.dart';

class RSMPushHistoryCubit extends Cubit<RSMPushHistoryState> {
  RSMPushHistoryCubit() : super(const RSMPushHistoryState());

  final _repository = LegendaryRepository();

  getNotificationLogs() async {
    emit(state.copyWith(status: BlocStatus.loading));
    BaseModel<List<CollaboratorRsmPushLogModel>> result = await _repository.getRSMPushLog();
    int currentMonth = DateTime.now().month;
    emit(state.copyWith(
      status: BlocStatus.success,
      data: result.data,
      currentMonth: currentMonth,
      selectedMonth: currentMonth,
    ));
    getLogsByMonth(currentMonth);
  }

  setPreviousMonth() {
    if (state.selectedMonth == 1) return;
    int selectedMonth = state.selectedMonth - 1;
    getLogsByMonth(selectedMonth);
  }

  setNextMonth() {
    if (state.selectedMonth == 12) return;
    int selectedMonth = state.selectedMonth + 1;
    getLogsByMonth(selectedMonth);
  }

  getLogsByMonth(int selectedMonth) {
    final filterData = state.data.where((element) {
      final processStarted = DateTimeUtil.getDate(
        element.processStarted ?? '',
        format: DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
        isFromUTC: false,
      );
      final month = processStarted?.month;
      return month == selectedMonth;
    }).toList();
    filterData.sort((a,b) {
      final aDate = DateTimeUtil.getDate(
        a.processStarted ?? '',
        format: DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
        isFromUTC: false,
      )?.millisecondsSinceEpoch ?? 0;
      final bDate = DateTimeUtil.getDate(
        b.processStarted ?? '',
        format: DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
        isFromUTC: false,
      )?.millisecondsSinceEpoch ?? 0;
      return bDate.compareTo(aDate);
    });
    emit(state.copyWith(filterData: filterData, selectedMonth: selectedMonth));
  }
}

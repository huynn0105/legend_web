import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/extension/datetime_extension.dart';

part 'date_selection_state.dart';

class DateSelectionCubit extends Cubit<DateSelectionState> {
  DateSelectionCubit() : super(DateSelectionState());

  updateDate(DateTime date) {
    final now = DateTime.now().toFirstDayInDateOnly();
    emit(state.copyWith(
      date: date.toFirstDayInDateOnly(),
      enabledNextMonth: date.isBefore(now),
    ));
  }

  nextMonth() {
    final date = state.date.copyWith(month: state.date.month + 1);
    final now = DateTime.now().toFirstDayInDateOnly();

    emit(state.copyWith(
      date: date,
      enabledNextMonth: date.isBefore(now),
    ));
  }

  previousMonth() {
    final date = state.date.copyWith(month: state.date.month - 1);
    final now = DateTime.now().toFirstDayInDateOnly();

    emit(state.copyWith(
      date: date,
      enabledNextMonth: date.isBefore(now),
    ));
  }
}

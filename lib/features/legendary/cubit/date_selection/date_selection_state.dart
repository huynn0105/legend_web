part of 'date_selection_cubit.dart';

class DateSelectionState extends Equatable {
  DateSelectionState({
    DateTime? date,
    this.enabledNextMonth = false,
    this.enabledPreviousMonth = true,
  }) : date = date ?? DateTime.now().toFirstDayInDateOnly();

  final DateTime date;
  final bool enabledNextMonth;
  final bool enabledPreviousMonth;

  @override
  List<Object> get props => [
        date,
        enabledNextMonth,
        enabledPreviousMonth,
      ];

  DateSelectionState copyWith({
    DateTime? date,
    bool? enabledNextMonth,
    bool? enabledPreviousMonth,
  }) {
    return DateSelectionState(
      date: date ?? this.date,
      enabledNextMonth: enabledNextMonth ?? this.enabledNextMonth,
      enabledPreviousMonth: enabledPreviousMonth ?? this.enabledPreviousMonth,
    );
  }
}

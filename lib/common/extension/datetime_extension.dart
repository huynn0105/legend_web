import 'package:flutter/material.dart';

extension ExDateTime on DateTime {
  DateTime dateOnly() {
    return DateUtils.dateOnly(this);
  }

  DateTime toFirstDayInDateOnly() {
    return dateOnly().copyWith(day: 1);
  }

  DateTime addMonth(int month) {
    return DateTime(year, this.month + month, day);
  }

  DateTime toMonth() {
    return DateTime(year, month);
  }

  DateTime toLastDay() {
    return DateTime(year, month, day, 23, 59, 59);
  }

  DateTime setDay(int newDay) {
    return DateTime(year, month, newDay);
  }

  DateTime startOfWeek() => subtract(Duration(days: weekday - 1)).dateOnly();
  DateTime endOfWeek() => add(Duration(days: DateTime.daysPerWeek - weekday)).dateOnly();

  int getTotalWeeksOfMonth() {
    int count = 0;
    DateTime week = toFirstDayInDateOnly();
    final thisMonth = month;
    while (week.month == thisMonth) {
      DateTime startOfWeek = week.startOfWeek();
      DateTime endOfWeek = week.endOfWeek();
      if (startOfWeek.month != thisMonth) {
        startOfWeek = toFirstDayInDateOnly();
      }
      if (endOfWeek.month != thisMonth) {
        endOfWeek = lastDayOfMonth();
      }
      count++;
      week = endOfWeek.add(const Duration(days: 1));
    }
    return count;
  }

  DateTime lastDayOfMonth() => DateTime(
    year,
    month + 1,
  ).subtract(const Duration(days: 1));
}

import 'package:legend_mfast/common/extension/datetime_extension.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:legend_mfast/common/utils/text_util.dart';

enum DateTimeFormat {
  dd_MM_yyyy,
  ddMMyyyy,
  dd__MM__yyyy,
  dd_MMM_yyyy,
  yyyy_MM_dd,
  HHmm,
  HHmmss,
  yyyy_MM_ddTHH_mm_ssSS,
  HH_mm_dd_MM_yyyy,
  HH_mm_dd_MM,
  HH_mm_n_dd_MM_yyyy,
  dd_MM_yyyy_HH_mm,
  dd_MM_yyyy_HH_mm_ss,
  dd_MM_yyyy_at_HH_mm,
  yyyy_MM_dd_HH_mm_ss,
  MM_yyyy,
  yyyy_MM,
  dd_MM_yyyy_n_HH_mm,
  dd_MM,
  yyyyMM,
  EEE,
  EEEE_dd_MM,
}

extension DateTimeFormatExtension on DateTimeFormat {
  String get getString {
    switch (this) {
      case DateTimeFormat.yyyy_MM_ddTHH_mm_ssSS:
        return "yyyy-MM-ddTHH:mm:ssZ";
      case DateTimeFormat.ddMMyyyy:
        return "dd/MM/yyyy";
      case DateTimeFormat.dd_MM_yyyy:
        return "dd-MM-yyyy";
      case DateTimeFormat.dd_MMM_yyyy:
        return "dd-MMM-yyyy";
      case DateTimeFormat.yyyy_MM_dd:
        return "yyyy-MM-dd";
      case DateTimeFormat.HHmm:
        return "HH:mm";
      case DateTimeFormat.HHmmss:
        return "HH:mm:ss";
      case DateTimeFormat.HH_mm_dd_MM_yyyy:
        return "HH:mm - dd/MM/yyyy";
      case DateTimeFormat.HH_mm_dd_MM:
        return "HH:mm - dd/MM";
      case DateTimeFormat.HH_mm_n_dd_MM_yyyy:
        return "HH:mm\ndd/MM/yyyy";
      case DateTimeFormat.dd_MM_yyyy_HH_mm:
        return "dd/MM/yyyy, HH:mm";
      case DateTimeFormat.dd_MM_yyyy_HH_mm_ss:
        return "dd/MM/yyyy HH:mm:ss";
      case DateTimeFormat.yyyy_MM_dd_HH_mm_ss:
        return "yyyy-MM-dd HH:mm:ss";
      case DateTimeFormat.MM_yyyy:
        return "MM / yyyy";
      case DateTimeFormat.yyyy_MM:
        return "yyyy-MM";
      case DateTimeFormat.dd_MM_yyyy_at_HH_mm:
        return "dd/MM/yyyy {} HH:mm";
      case DateTimeFormat.dd_MM_yyyy_n_HH_mm:
        return "dd/MM/yyyy\nHH:mm";
      case DateTimeFormat.dd_MM:
        return "dd/MM";
      case DateTimeFormat.EEE:
        return "EEE";
      case DateTimeFormat.yyyyMM:
        return "yyyy-MM";
      case DateTimeFormat.EEEE_dd_MM:
        return "EEEE, dd/MM";
      case DateTimeFormat.dd__MM__yyyy:
      default:
        return "dd/MM/yyyy";
    }
  }
}

class DateTimeUtil {
  DateTimeUtil._();

  static String convertDate(
      String? dateString, {
        DateTimeFormat fromFormat = DateTimeFormat.dd_MM_yyyy,
        DateTimeFormat toFormat = DateTimeFormat.yyyy_MM_dd,
        bool isFromUtc = true,
        String? locale,
      }) {
    if ((locale ?? '').isNotEmpty) {
      initializeDateFormatting();
    }

    if (TextUtils.isEmpty(dateString)) return '';
    if (isFromUtc) {
      final date = DateFormat(fromFormat.getString).parseUTC(dateString!).toLocal();
      return DateFormat(toFormat.getString, locale).format(date);
    }
    final date = DateFormat(fromFormat.getString).parse(dateString!);
    return DateFormat(toFormat.getString, locale).format(date);
  }

  static DateTime? getDate(
      String date, {
        DateTimeFormat format = DateTimeFormat.dd_MM_yyyy,
        bool isFromUTC = true,
      }) {
    try {
      if (isFromUTC) {
        return DateFormat(format.getString).parseUTC(date).toLocal();
      }
      return DateFormat(format.getString).parse(date).toLocal();
    } catch (e) {
      return null;
    }
  }

  static String getString(
      DateTime date, {
        DateTimeFormat format = DateTimeFormat.dd_MM_yyyy,
      }) {
    try {
      return DateFormat(format.getString, 'vi').format(date);
    } catch (e) {
      throw FormatException('Characters remaining after date parsing in $date');
    }
  }

  static bool isDate(
      String input, {
        DateTimeFormat format = DateTimeFormat.dd_MMM_yyyy,
      }) {
    try {
      DateFormat(format.getString).parseStrict(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String convertTimeAgo(
      String? dateString, {
        DateTimeFormat format = DateTimeFormat.yyyy_MM_ddTHH_mm_ssSS,
        bool isFromUtc = true,
        bool isFormatDateName = false,
      }) {
    if (TextUtils.isEmpty(dateString)) return '';
    final notificationDate = isFromUtc
        ? DateFormat(format.getString).parseUTC(dateString!)
        : DateFormat(format.getString).parse(dateString!);
    final now = DateTime.now();
    final difference = now.difference(notificationDate);

    if (difference.inDays >= 365) {
      return '${(difference.inDays / 365).floor()}${isFormatDateName ? ' năm' : 'Y'}';
    } else if (difference.inDays >= 30) {
      return '${(difference.inDays / 30).floor()}${isFormatDateName ? ' tháng' : 'M'}';
    } else if (difference.inDays >= 7) {
      return '${(difference.inDays / 7).floor()}${isFormatDateName ? ' tuần' : 'W'}';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays}${isFormatDateName ? ' ngày' : 'D'}';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}${isFormatDateName ? ' giờ' : 'H'}';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}${isFormatDateName ? ' phút' : 'M'}';
    } else {
      return '${difference.inSeconds}${isFormatDateName ? ' giây' : 'S'}';
    }
  }

  static bool isUnderage(DateTime birthDate, int year) {
    // Current time - at this moment
    DateTime today = DateTime.now();

    // Date to check but moved 18 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + year,
      birthDate.month,
      birthDate.day,
    );

    return adultDate.isAfter(today);
  }

  static bool isOverage(DateTime birthDate, int year) {
    // Current time - at this moment
    DateTime today = DateTime.now();

    // Date to check but moved 18 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + year,
      birthDate.month,
      birthDate.day,
    );

    return adultDate.isBefore(today);
  }

  static String convertTodayDate(
      String? dateString, {
        DateTimeFormat fromFormat = DateTimeFormat.dd_MM_yyyy,
        DateTimeFormat toFormat = DateTimeFormat.yyyy_MM_dd,
        bool isFromUtc = true,
      }) {
    if (TextUtils.isEmpty(dateString)) return '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isToday = today.difference(DateTime.parse(dateString ?? '').dateOnly()).inDays == 0;

    if (isFromUtc) {
      final date = DateFormat(fromFormat.getString).parseUTC(dateString!).toLocal();
      return isToday
          ? 'Hôm nay\n${DateFormat(DateTimeFormat.HHmm.getString).format(date)}'
          : DateFormat(toFormat.getString).format(date);
    }
    final date = DateFormat(fromFormat.getString).parse(dateString!);
    return isToday
        ? 'Hôm nay\n${DateFormat(DateTimeFormat.HHmm.getString).format(date)}'
        : DateFormat(toFormat.getString).format(date);
  }

  static DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  static DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  static int convertStringRemainSeconds(
      String? date, {
        DateTimeFormat format = DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
        bool isFromUtc = true,
        bool isUnSignSecond = true,
      }) {
    if (TextUtils.isEmpty(date)) {
      return 0;
    }
    DateTime? dt = DateTimeUtil.getDate(
      date!,
      format: format,
      isFromUTC: isFromUtc,
    );
    if (dt == null) {
      return 0;
    }
    int seconds = dt.difference(DateTime.now()).inSeconds;
    if (!isUnSignSecond) {
      return seconds;
    }
    return seconds < 0 ? 0 : seconds;
  }

  static String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  static String formatRemainSecond(
      int remainSeconds, {
        bool showDays = true,
        bool showHours = true,
        bool showRemainHourPerDay = false,
        bool showMinutes = true,
        bool showRemainHourPerHour = false,
        bool showSeconds = false,
        bool showRemainSecondPerMinute = false,
      }) {
    Duration duration = Duration(seconds: remainSeconds);
    int days = duration.inDays;
    int hours = showRemainHourPerDay ? duration.inHours.remainder(24) : duration.inHours;
    int minutes = showRemainHourPerHour ? duration.inMinutes.remainder(60) : duration.inMinutes;
    int seconds = showRemainSecondPerMinute ? duration.inSeconds.remainder(60) : duration.inSeconds;
    return [
      if (days > 0 && showDays) "$days ngày",
      if (hours > 0 && showHours) "$hours giờ",
      if (minutes > 0 && showMinutes) "$minutes phút",
      if (seconds > 0 && (days + hours + minutes) == 0 && showSeconds) "$seconds giây",
    ].join(" ");
  }

  static String formatDuration(Duration duration) {
    return RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch("$duration")?.group(1) ?? '$duration';
  }

  static String getNumberDayBetween(
      String? time, {
        bool isShowDay = true,
        DateTimeFormat? Function(Duration duration)? forceShowDateFormat,
      }) {
    DateTime? date = time != null
        ? getDate(
      time,
      isFromUTC: false,
      format: DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
    )
        : null;
    String result = '';

    if (date != null) {
      Duration difference = DateTime.now().difference(date);

      final format = forceShowDateFormat?.call(difference);
      if (format != null) {
        return convertDate(
          time,
          fromFormat: DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
          toFormat: format,
          isFromUtc: false,
        );
      }

      if (difference.inDays > 0) {
        if (difference.inDays > 29) {
          int month = difference.inDays ~/ 30;
          int day = difference.inDays % 30;

          result =
          '${month > 0 ? '$month ${day > 0 && isShowDay ? 'tháng' : 'tháng trước'}' : ''} ${day > 0 && isShowDay ? '$day ngày trước' : ''}';
        } else {
          result = '${difference.inDays} ngày trước';
        }
      } else {
        int diffHour = difference.inHours;
        if (diffHour > 0) {
          result = '$diffHour giờ trước';
        } else {
          int diffMinute = difference.inMinutes;
          if (diffMinute > 0) {
            result = '$diffMinute phút trước';
          } else {
            result = 'Vừa xong';
          }
        }
      }
    }

    return result;
  }

  static getRemainSeconds(
      String? dateString, {
        DateTimeFormat format = DateTimeFormat.yyyy_MM_ddTHH_mm_ssSS,
        bool isFromUtc = true,
      }) {
    if (TextUtils.isEmpty(dateString)) return 0;
    final notificationDate = isFromUtc
        ? DateFormat(format.getString).parseUTC(dateString!)
        : DateFormat(format.getString).parse(dateString!);
    final now = DateTime.now();
    final difference = now.difference(notificationDate);

    return difference.inSeconds.abs();
  }
}

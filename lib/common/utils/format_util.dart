import 'package:intl/intl.dart';

import '../constants.dart';

class FormatUtil {
  FormatUtil._();

  static String currencyFormat(int? amount, {
    bool showUnit = true,
    bool format = true,
    bool suffix = false,
  }) {
    if (format) {
      final formatCurrency = NumberFormat.simpleCurrency(
        locale: 'vi_VN',
        name: '',
        decimalDigits: 0,
      );
      return '${formatCurrency.format(amount ?? 0).trim()}${showUnit ? AppConstants.vndCurrencySymbol : ''}';
    }
    return '${amount ?? 0}${showUnit ? AppConstants.vndCurrencySymbol : ''}';
  }

  static String pointFormat(
    double? amount, {
    bool showUnit = true,
    bool format = true,
    bool suffix = false,
  }) {
    if (format) {
      final formatCurrency = NumberFormat.simpleCurrency(
        locale: 'vi_VN',
        name: '',
        decimalDigits: 0,
      );
      return '${formatCurrency.format(amount ?? 0).trim()}${showUnit ? 'điểm' : ''}';
    }
    return '${amount ?? 0}${showUnit ? 'điểm' : ''}';
  }

  static String phoneFormat(String phone) {
    String result = "";
    if (phone.length < 10) return phone;

    for (int i = phone.length - 1; i >= 0; i = i - 1) {
      if (i != 0 && i != phone.length - 1 && ((phone.length - i) % 3 == 0 && i > 3)) {
        result = ".${phone[i]}$result";
      } else {
        result = "${phone[i]}$result";
      }
    }
    return result;
  }

  static String numberFormat(
    double? amount, {
    bool showUnit = true,
    String thousandSymbol = 'K',
    String millionSymbol = 'M',
  }) {
    if (amount == null) {
      return '0${!showUnit ? '' : AppConstants.vndCurrencySymbol}';
    }
    if (amount < 1000) {
      return '${amount.round()}${!showUnit ? '' : AppConstants.vndCurrencySymbol}';
    }
    if (amount < 10000) {
      int temp = (amount / 1000).round();
      return '$temp${!showUnit ? '' : thousandSymbol}';
    }
    if (amount < 1000000) {
      int temp = (amount / 100).round(); //exam 100150 -> 1002
      double? display = temp / 10; // 1002 -> display 100.2K

      //exam: 10049 -> 10K, 10050 -> 10.1K
      if (amount % 1000 < 50) {
        return '${display.round()}${!showUnit ? '' : thousandSymbol}';
      }

      return '$display${!showUnit ? '' : thousandSymbol}'; // 1002 -> display 100.2K
    }
    int temp = (amount / 100000).round(); //exam 1.000.150.000 -> 1002
    double? display = temp / 10; // 1002 -> display 100.2M\

    //1.000.049.000 -> 10M, 1.000.050.000 -> 10.1M
    if (amount % 1000000 < 50000) {
      return '${display.round()}${!showUnit ? '' : millionSymbol}';
    }

    return '$display${!showUnit ? '' : millionSymbol}';
  }

  static String currencyDoubleFormat(double? amount, {
    bool showUnit = true,
    bool format = true,
    bool suffix = false,
    int decimalDigit = 2,
  }) {
    if (format) {
      final formatCurrency = NumberFormat("#,##0.${"#" * decimalDigit}", "vi_VN");
      return '${formatCurrency.format(amount ?? 0).trim()}${showUnit ? AppConstants.vndCurrencySymbol : ''}';
    }
    return '${amount ?? 0}${showUnit ? AppConstants.vndCurrencySymbol : ''}';
  }

  static String doubleFormat(double? amount, {
    bool format = true,
    int decimalDigit = 2,
  }) {
    return currencyDoubleFormat(
      amount,
      showUnit: false,
      format: format,
      decimalDigit: decimalDigit,
    );
  }

  static String formatNumberByThousandSeparator(double n, {int digits = 1}) {
    if (n < 1e3) {
      return n.toStringAsFixed(digits);
    } else if (n >= 1e3 && n < 1e6) {
      return '${FormatUtil.doubleFormat(n / 1e3, decimalDigit: digits)} nghìn';
    } else if (n >= 1e6 && n < 1e9) {
      return '${FormatUtil.doubleFormat(n / 1e6, decimalDigit: digits)} triệu';
    } else if (n >= 1e9 && n < 1e12) {
      return '${FormatUtil.doubleFormat(n / 1e9, decimalDigit: digits)} tỉ';
    } else if (n >= 1e12) {
      return '${FormatUtil.doubleFormat(n / 1e12, decimalDigit: digits)} trăm tỉ';
    } else {
      return '';
    }
  }
}

import 'package:intl/intl.dart';

class FormatNumber {
  static String number(double number, [int decimals = 0]) {
    final formatNumber = NumberFormat.compactCurrency(
            decimalDigits: decimals, symbol: '', locale: 'en')
        .format(number);

    return formatNumber;
  }

  static String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }
}

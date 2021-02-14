import 'package:intl/intl.dart';

class NumberFormater {
  static String formatCurrency(double value) {
    var formater = new NumberFormat.currency(locale: "pt_BR", symbol: "R\$");
    return formater.format(value);
  }
}

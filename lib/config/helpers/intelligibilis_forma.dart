import 'package:intl/intl.dart';

class IntelligibilisForma {
  static String navaFormaNumeri(double numerus, [int decimales = 0]) {
    return NumberFormat.compactCurrency(
      decimalDigits: decimales,
      symbol: "",
      locale: "en",
    ).format(numerus);
  }
}

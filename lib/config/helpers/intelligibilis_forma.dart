import 'package:intl/intl.dart';

class IntelligibilisForma {
  static String navaFormaNumeri(double numerus) {
    return NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: "",
      locale: "en",
    ).format(numerus);
  }
}

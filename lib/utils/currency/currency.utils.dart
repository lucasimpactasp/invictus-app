import 'package:intl/intl.dart';

class CurrencyUtil {
  static int cleanCurrencyMask(String value) {
    return int.parse(
        value.replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', ''));
  }

  static String addCurrencyMask(dynamic value,
      {String symbol, String decimal = '.'}) {
    final numberFormatter = NumberFormat.currency(
      symbol: 'R\$',
      locale: 'pt-BR',
    );

    String formatedCurrency = numberFormatter.format(value);

    return formatedCurrency;
  }
}

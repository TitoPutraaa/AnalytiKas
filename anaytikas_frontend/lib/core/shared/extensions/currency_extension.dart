import 'package:intl/intl.dart';

extension CurrencyExtension on num {
  // 10000 -> Rp 10.000
  String toRupiah() {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(this);
  }

  // 10000 -> 10.000
  String toThoushandsSeparator() {
    return NumberFormat.decimalPattern('id_ID').format(this);
  }
}

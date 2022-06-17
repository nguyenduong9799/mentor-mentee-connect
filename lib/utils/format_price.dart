import 'package:intl/intl.dart';

String formatPrice(double price) {
  return NumberFormat.simpleCurrency(locale: 'vi').format(price);
}

String formatPriceWithoutUnit(double price) {
  NumberFormat format = NumberFormat("###0.00");
  format.minimumFractionDigits = 0;
  return format.format(price);
}

String formatBean(double price) {
  NumberFormat format = NumberFormat("###0.00");
  format.minimumFractionDigits = 0;
  return format.format(price);
}

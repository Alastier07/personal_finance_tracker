import 'package:intl/intl.dart';

String currencyFormat(double amount) {
  return '\$${NumberFormat("#,##0.00", "en_US").format(amount)}';
}

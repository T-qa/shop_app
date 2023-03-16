import 'cart_item.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime date;
  final List<CartItem> items;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.date,
      required this.items});
}

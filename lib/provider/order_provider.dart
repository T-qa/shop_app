import 'package:flutter/material.dart';
import '../models/order_item.dart';
import '../models/cart_item.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItems, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now() as String,
            amount: total,
            date: DateTime.now(),
            items: cartItems));
  }
}

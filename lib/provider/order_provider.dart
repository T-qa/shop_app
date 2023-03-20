import 'package:flutter/material.dart';
import '../models/order_item.dart';
import '../models/cart_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    var url = Uri.https(
        'https://swift-fabric-338810-default-rtdb.asia-southeast1.firebasedatabase.app/orders');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          date: DateTime.parse(orderData['dateTime']),
          items: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartItems, double total) async {
    var url = Uri.https(
        'https://swift-fabric-338810-default-rtdb.asia-southeast1.firebasedatabase.app/orders');
    final timeStamp = DateTime.now();
    final response = await http.post(url, body: {
      'amount': total,
      'date': timeStamp.toIso8601String(),
      'items': cartItems
          .map((cartItem) => {
                'id': cartItem.id,
                'title': cartItem.title,
                'quantity': cartItem.quantity,
                'price': cartItem.price,
              })
          .toList(),
    });
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            date: timeStamp,
            items: cartItems));
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/order_product.dart';
import '../provider/order_provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orderProvider.orders.length,
        itemBuilder: (context, index) => OrderProduct(orderProvider.orders[index]),
      ),
    );
  }
}

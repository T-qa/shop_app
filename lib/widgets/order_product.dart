import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order_item.dart';

class OrderProduct extends StatelessWidget {
  final OrderItem orderItem;

  OrderProduct(this.orderItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${orderItem.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(orderItem.date),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

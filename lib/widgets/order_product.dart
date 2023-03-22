import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order_item.dart';

class OrderProduct extends StatefulWidget {
  final OrderItem orderItem;

  OrderProduct(this.orderItem);

  @override
  State<OrderProduct> createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  bool _expandable = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(widget.orderItem.date),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expandable = !_expandable;
                });
              },
            ),
          ),
          _expandable
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  height: min(widget.orderItem.items.length * 20.0 + 10, 100),
                  child: ListView(
                    children: widget.orderItem.items
                        .map(
                          (product) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                product.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${product.quantity}x \$${product.price}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ),
                )
              : const Text('No items')
        ],
      ),
    );
  }
}

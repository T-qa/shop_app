import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/order_product.dart';
import '../provider/order_provider.dart';
import '../widgets/drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/order';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future? _futureOrder;
  Future _obtainOrderFuture() {
    return Provider.of<OrderProvider>(context, listen: false)
        .fetchAndSetOrders();
  }

  @override
  void initState() {
    _futureOrder = _obtainOrderFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: _futureOrder,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // ...
              // Do error handling stuff
              return const Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<OrderProvider>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (context, index) => OrderProduct(orderData.orders[index]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

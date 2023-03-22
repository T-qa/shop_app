import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './provider/product_prodvider.dart';
import 'provider/cart_provider.dart';
import './screens/cart_screen.dart';
import './provider/order_provider.dart';
import './screens/order_screen.dart';
import './screens/product_edit_screen.dart';
import './screens/user_products_screen.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        )
      ],
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.deepOrange)),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
          UserProductsScreen.routeName:(context) => UserProductsScreen(),
        },
      ),
    );
  }
}

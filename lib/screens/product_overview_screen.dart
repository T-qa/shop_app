import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../provider/cart.dart';

enum FilterOptions { favorites, all }

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Shop'),
          actions: [
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem(
                    value: FilterOptions.favorites,
                    child: Text('Only Favorites')),
                const PopupMenuItem(
                    value: FilterOptions.all, child: Text('Show all')),
              ],
            ),
            Consumer<Cart>(
              builder: (context, item, child) {
                return CartBadge(
                  value: item.itemCount.toString(),
                  child: child!
                );
              },
              child: IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {
                    
                  },),
            )
          ],
        ),
        body: ProductGrid(_showOnlyFavorites));
  }
}

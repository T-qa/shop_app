import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../provider/cart_provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final singleProductProvider = Provider.of<Product>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        footer: GridTileBar(
          trailing: IconButton(
              onPressed: () {
                cartProvider.addItem(singleProductProvider.id,
                    singleProductProvider.price, singleProductProvider.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.purple,
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          cartProvider.undoAddedItem(singleProductProvider.id);
                        }),
                    content: const Text('Sucessfully added new item')));
              },
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).colorScheme.secondary),
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                product.toggleFavorite();
              },
            ),
          ),
          backgroundColor: Colors.black54,
          title: Text(
            singleProductProvider.title,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: singleProductProvider.id);
          },
          child: Image.network(
            singleProductProvider.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

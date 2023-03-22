import 'package:flutter/material.dart';
import '../provider/product_prodvider.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;

  ProductGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final allProducts = showFavs ? productProvider.favoriteItems : productProvider.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: allProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: allProducts[index],
              child: ProductItem(),
            ));
  }
}

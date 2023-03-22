import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class ProductProvider with ChangeNotifier {
  Future<void> fetchData() async {
    var url = Uri.parse(
        'https://flutter-shop-66a13-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> newList = [];
      extractedData.forEach((productId, productData) {
        newList.add(Product(
          description: productData['description'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
          price: productData['price'],
          title: productData['title'],
          id: productId,
        ));
      });
      _items = newList;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse(
        'https://flutter-shop-66a13-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
    try {
      var response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }));
      final responseData = json.decode(response.body);
      final newProduct = Product(
          id: responseData['name'],
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price,
          title: product.title,
          isFavorite: product.isFavorite);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    var url = Uri.parse(
        'https://flutter-shop-66a13-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {}
  }

  Future<void> deleteProduct(String id) async {
    var url = Uri.parse(
        'https://flutter-shop-66a13-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
    final existingProdIndex = _items.indexWhere((product) => product.id == id);
    Product? existingProd = _items[existingProdIndex];
    _items.removeAt(existingProdIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProdIndex, existingProd);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProd = null;
  }
}

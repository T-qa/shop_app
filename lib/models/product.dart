import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  void setFavoriteStatus(bool newFavoriteStatus) {
    isFavorite = newFavoriteStatus;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    var oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    var url = Uri.https(
        'https://swift-fabric-338810-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id');
    try {
      var response =
          await http.patch(url, body: json.encode({'isFavorite': isFavorite}));

      if (response.statusCode >= 400) {
        setFavoriteStatus(oldStatus);
        notifyListeners();
      }
    } catch (error) {
      setFavoriteStatus(oldStatus);
    }
  }
}

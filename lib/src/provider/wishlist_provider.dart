import 'package:ecommerce_app/src/model/product.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Products> _favoriteItems = [];

  void addProduct(Products product) {
    _favoriteItems.add(product);
    notifyListeners();
  }

  void removeProduct(Products product) {
    _favoriteItems.remove(product);
    product.isLiked = false;
    notifyListeners();
  }

  void removeAllProduct() {
    for (var product in favoriteProducts) {
      product.isLiked = false;
    }
    _favoriteItems.clear();
    notifyListeners();
  }

  List<Products> get favoriteProducts {
    return _favoriteItems;
  }
}

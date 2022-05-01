import 'package:ecommerce_app/src/model/product.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Products> _items = [];
  num _checkoutPrice = 0.0;
  bool exist = false;

  void addProduct(Products product) {
    _items.add(product);
    _checkoutPrice += product.price!;
    notifyListeners();
  }

  void setQuantity(
      {required Products product,
      required bool isIncrement,
      required int index}) {
    if (isIncrement) {
      if (basketProducts[index].quantity < product.inStock!) {
        basketProducts[index].quantity++;
      }
    } else {
      basketProducts[index].quantity != 1
          ? basketProducts[index].quantity--
          : basketProducts[index].quantity;
    }
    notifyListeners();
  }

  void removeProduct(Products product) {
    _items.remove(product);
    _checkoutPrice -= product.price!;
    product.quantity = 1;
    notifyListeners();
  }

  void removeAllProduct() {
    for (var product in basketProducts) {
      product.quantity = 1;
    }
    _items.clear();
    notifyListeners();
  }

  num get totalAmount {
    _checkoutPrice = 0.0;
    for (var product in basketProducts) {
      _checkoutPrice += product.quantity * product.price!;
    }
    return _checkoutPrice;
  }

  int get productsCount {
    return _items.length;
  }

  List<Products> get basketProducts {
    return _items;
  }
}

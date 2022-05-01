import 'package:ecommerce_app/src/model/data.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';
import '../model/user.dart';
import '../services/api/api_services.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  ExtractProducts? extractProducts;
  final Token _token = Token();
  List<Products> products = [];
  bool listOrGrid = false;


  Future<void> getProducts(BuildContext context) async {
    _apiService.get(AppData.baseUrl + "products" ,
        headers: {'Authorization':'Bearer ${_token.token}'}).then((response) {
      if (response.statusCode == 200) {
        extractProducts = ExtractProducts.fromJson(response.data);
        products = extractProducts!.products;
        notifyListeners();
      }
    });
  }

  void isLiked(int index) {
    products[index].isLiked = !products[index].isLiked!;
    notifyListeners();
  }

  void isClicked() {
    listOrGrid = !listOrGrid;
    notifyListeners();
  }
}

import 'package:ecommerce_app/src/model/category.dart';
import 'package:ecommerce_app/src/model/data.dart';
import 'package:ecommerce_app/src/model/product.dart';
import 'package:flutter/material.dart';

import '../services/api/api_services.dart';

class CategoryProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  int? categoryId;
  ExtractCategories? extractCategories;
  ExtractProductsByItsCategory? extractProductsByItsCategory;
  List<Categories> categories = [];
  List<Products> products = [];
  List<String> showCategoriesList = [
    "https://images.unsplash.com/photo-1462392246754-28dfa2df8e6b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
    "https://images.unsplash.com/photo-1588508065123-287b28e013da?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    "https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1475&q=80",
    "https://images.unsplash.com/photo-1624876993483-6891db75df37?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
    "https://images.unsplash.com/photo-1571567494105-e0ab767f03bf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=671&q=80",
    "https://images.unsplash.com/photo-1604145187954-249d15732a10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472&q=80"
  ];

  CategoryProvider() {
    getCategories();
  }

  Future<void> getCategories() async {
    _apiService.get(AppData.baseUrl + "categories").then((response) {
      if (response.statusCode == 200) {
        extractCategories = ExtractCategories.fromJson(response.data);
        categories = extractCategories!.categories!;
        notifyListeners();
      }
    });
  }

  Future<void> getProductsByCategoryId(int _categoryId) async {
    categoryId = _categoryId;
    _apiService
        .get(AppData.baseUrl + "categories/$categoryId")
        .then((response) {
      if (response.statusCode == 200) {
        extractProductsByItsCategory =
            ExtractProductsByItsCategory.fromJson(response.data);
        products = extractProductsByItsCategory!.products!;
        notifyListeners();
      }
    });
  }

  void isLiked(int index) {
    products[index].isLiked = !products[index].isLiked!;
    notifyListeners();
  }
}

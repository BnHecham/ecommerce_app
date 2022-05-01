import 'package:ecommerce_app/src/model/product.dart';

class ExtractCategories {
  List<Categories>? categories;

  ExtractCategories({this.categories});

  ExtractCategories.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }
}

class ExtractProductsByItsCategory {
  Categories? category;
  List<Products>? products;

  ExtractProductsByItsCategory({this.category, this.products});

  ExtractProductsByItsCategory.fromJson(Map<String, dynamic> json) {
    category =
        json['category'] != null ? Categories.fromJson(json['category']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }
}

class Categories {
  int? id;
  String? name;
  String? avatar;
  List<Products>? products;

  Categories({this.id, this.name, this.avatar, this.products});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }
}

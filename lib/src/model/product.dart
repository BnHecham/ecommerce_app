import 'package:ecommerce_app/src/model/data.dart';

class ExtractProducts {
  ExtractProducts({required this.products});

  List<Products> products;

  factory ExtractProducts.fromJson(Map<String, dynamic> json) =>
      ExtractProducts(
          products: List<Products>.from(
              json["products"].map((x) => Products.fromJson(x))));
}

class Products {
  Products({
    this.id,
    this.name,
    this.title,
    this.categoryId,
    this.description,
    this.price,
    this.currency,
    this.inStock,
    this.avatar,
  });

  int? id;
  String? name;
  String? title;
  int? categoryId;
  String? description;
  num? price;
  String? currency;
  int? inStock;
  int quantity = 1;
  String? avatar;
  bool? isLiked = false;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        categoryId: json["category_id"],
        description: json["description"] ?? AppData.description,
        price: json["price"],
        currency: json["currency"],
        inStock: json["in_stock"],
        avatar: json["avatar"],
      );
}

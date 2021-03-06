import 'package:invictus/core/models/base.model.dart';
import 'package:invictus/core/models/product/product.model.dart';

class Category extends Model<String> {
  String id;
  String name;
  List<Product> products;

  Category({
    this.id,
    this.name,
    this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      products: json['products'] != null
          ? json['products']
              .map<Product>((product) => Product.fromJson(product))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'products': this.products != null
          ? this.products.map((product) => product.toJson()).toList()
          : null,
    };
  }
}

class CategoryParams extends Model<String> {
  String name;
  List<String> products;

  CategoryParams({
    this.name,
    this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'products': this.products,
    };
  }
}

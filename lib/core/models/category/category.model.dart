import 'package:invictus/core/models/product/product.model.dart';

class Category {
  String id;
  String name;
  String slug;
  List<Product> products;

  Category({
    this.id,
    this.name,
    this.slug,
    this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      products: json['products'] != null
          ? json['products']
              .map((product) => Product.fromJson(product))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson(Category product) {
    return {
      'id': this.id,
      'name': this.name,
      'slug': this.slug,
      'products': this.products != null
          ? this.products.map((product) => product.toJson(product)).toList()
          : null,
    };
  }
}

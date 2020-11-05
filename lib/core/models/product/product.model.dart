import 'package:invictus/core/models/base.model.dart';
import 'package:invictus/core/models/category/category.model.dart';
import 'package:invictus/core/models/user/user.model.dart';

class Product extends Model<String> {
  String id;
  String createdAt;
  String updateAt;
  String name;
  String description;
  int price;
  int quantity;
  String dimension;
  String imageUrl;
  Category category;
  User createdBy;

  Product({
    this.id,
    this.createdAt,
    this.updateAt,
    this.name,
    this.description,
    this.price,
    this.quantity,
    this.dimension,
    this.imageUrl,
    this.category,
    this.createdBy,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      createdAt: json['createdAt'],
      updateAt: json['updateAt'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      dimension: json['dimension'],
      imageUrl: json['imageUrl'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      createdBy:
          json['createdBy'] != null ? User.fromJson(json['createdBy']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': this.createdAt,
      'updateAt': this.updateAt,
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'quantity': this.quantity,
      'dimension': this.dimension,
      'imageUrl': this.imageUrl,
      'category': this.category != null ? this.category.id : null,
      'vendor': '',
    };
  }
}

import 'package:invictus/core/models/base.model.dart';
import 'package:invictus/core/models/category/category.model.dart';
import 'package:invictus/core/models/user/user.model.dart';
import 'package:invictus/core/models/vendor/vendor.model.dart';

class Product extends Model<String> {
  String id;
  DateTime createdAt;
  String updateAt;
  String name;
  String description;
  int price;
  int quantity;
  String dimension;
  String imageUrl;
  Category category;
  User createdBy;
  Vendor vendor;

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
    this.vendor,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    DateTime createdAt;

    if (json['created_at'] != null) {
      createdAt = DateTime.parse(json['created_at']);
    }

    return Product(
      id: json['id'],
      createdAt: createdAt,
      updateAt: json['update_at'],
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
      vendor: json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null,
    );
  }

  Map<String, dynamic> toJson({bool addId = false}) {
    Map<String, dynamic> response = {
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'quantity': this.quantity,
      'dimension': this.dimension,
      'imageUrl': this.imageUrl,
      'category': this.category != null ? this.category.id : null,
      'vendor': this.vendor != null ? this.vendor.id : null,
    };

    if (addId) {
      response['id'] = this.id;
    }

    return response;
  }
}

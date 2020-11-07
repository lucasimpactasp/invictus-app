import 'package:invictus/core/models/base.model.dart';
import 'package:invictus/core/models/product/product.model.dart';

class Vendor extends Model<String> {
  String id;
  String name;
  String phone;
  String email;
  List<Product> products;

  Vendor({
    this.email,
    this.id,
    this.name,
    this.phone,
    this.products,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      email: json['email'],
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
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
      'phone': this.phone,
      'email': this.email,
      'products': this.products != null
          ? this.products.map((e) => e.toJson()).toList()
          : null,
    };
  }
}

class VendorParams extends Model<String> {
  String name;
  String phone;
  String email;
  List<String> products;

  VendorParams({
    this.email,
    this.name,
    this.phone,
    this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'phone': this.phone,
      'email': this.email,
      'products': this.products,
    };
  }
}

import 'package:invictus/core/models/base.model.dart';
import 'package:invictus/core/models/invoice/invoice.model.dart';
import 'package:invictus/core/models/product/product.model.dart';

class User extends Model<String> {
  String id;
  String firstName;
  String lastName;
  String gender;
  String email;
  String username;
  String password;
  String role;
  List<Product> products;
  List<Invoice> madeInvoices;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.username,
    this.password,
    this.role,
    this.products,
    this.madeInvoices,
  });

  factory User.fromJson(Map<String, dynamic> json,
      {bool transformInInstance = true}) {
    print(json['madeInvoices']);
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      role: json['role'],
      products: json['products'] != null
          ? !transformInInstance
              ? json['products']
              : json['products']
                  .map<Product>((product) => Product.fromJson(product))
                  .toList()
          : null,
      madeInvoices: json['madeInvoices'] != null
          ? transformInInstance
              ? json['madeInvoices']
                  .map<Invoice>((invoice) => Invoice.fromJson(invoice))
                  .toList()
              : json['madeInvoices']
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'gender': this.gender,
      'email': this.email,
      'username': this.username,
      'password': this.password,
      'role': this.role,
      'products': this.products != null
          ? this.products.map((e) => e.toJson()).toList()
          : null,
      'madeInvoices': this.madeInvoices != null
          ? this.madeInvoices.map((e) => e.toJson()).toList()
          : null,
    };
  }
}

class UserParams extends Model<String> {
  String firstName;
  String lastName;
  String gender;
  String email;
  String username;
  String password;
  String role;
  List<String> products;
  List<String> madeInvoices;

  UserParams({
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.username,
    this.password,
    this.role,
    this.products,
    this.madeInvoices,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'gender': this.gender,
      'email': this.email,
      'username': this.username,
      'password': this.password,
      'role': this.role,
      'products': this.products,
      'madeInvoices': this.madeInvoices,
    };
  }
}

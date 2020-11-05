import 'package:invictus/core/models/base.model.dart';
import 'package:invictus/core/models/product/product.model.dart';

class User extends Model<String> {
  String firstName;
  String lastName;
  String gender;
  String email;
  String username;
  String password;
  DateTime birthday;
  DateTime lastDateLogin;
  String role;
  List<Product> products;

  User({
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.username,
    this.password,
    this.birthday,
    this.lastDateLogin,
    this.role,
    this.products,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    DateTime birthday;
    DateTime lastDateLogin;

    if (json['birthday'] != null) {
      birthday = DateTime.parse(json['birthday']);
    }

    if (json['lastDateLogin'] != null) {
      lastDateLogin = DateTime.parse(json['lastDateLogin']);
    }

    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      birthday: birthday,
      lastDateLogin: lastDateLogin,
      role: json['role'],
      products: json['products'] != null
          ? json['products']
              .map((product) => Product.fromJson(product))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    String birthday;
    String lastDateLogin;

    if (this.birthday != null) {
      birthday = this.birthday.toIso8601String();
    }

    if (this.lastDateLogin != null) {
      lastDateLogin = this.lastDateLogin.toIso8601String();
    }

    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'gender': this.gender,
      'email': this.email,
      'username': this.username,
      'password': this.password,
      'birthday': birthday,
      'lastDateLogin': lastDateLogin,
      'role': this.role,
      'products': this.products != null
          ? this.products.map((e) => e.toJson()).toList()
          : null,
    };
  }
}

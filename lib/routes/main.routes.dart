import 'package:flutter/material.dart';
import 'package:invictus/screens/home/home.screen.dart';
import 'package:invictus/screens/login/login.screen.dart';
import 'package:invictus/screens/product/create-product.screen.dart';
import 'package:invictus/screens/product/product.screen.dart';
import 'package:invictus/screens/products/products.screen.dart';

class Routes {
  static getRoutes() {
    return {
      '/login': (BuildContext context) => Login(),
      '/home': (BuildContext context) => Home(),
      '/product': (BuildContext context) => ProductScreen(),
      '/products': (BuildContext context) => ProductsScreen(),
      '/create-product': (BuildContext context) => CreateProduct(),
    };
  }
}

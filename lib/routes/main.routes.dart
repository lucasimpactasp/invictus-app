import 'package:flutter/material.dart';
import 'package:invictus/screens/home/home.screen.dart';
import 'package:invictus/screens/login/login.screen.dart';

class Routes {
  static getRoutes() {
    return {
      '/login': (BuildContext context) => Login(),
      '/home': (BuildContext context) => Home(),
    };
  }
}

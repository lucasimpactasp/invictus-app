import 'package:flutter/material.dart';
import 'package:invictus/screens/home/home.screen.dart';

class Routes {
  static getRoutes() {
    return {
      '/home': (BuildContext context) => Home(),
    };
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/routes/main.routes.dart';

void main() {
  runApp(InvictusApp());
}

class InvictusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: Routes.getRoutes(),
      initialRoute: '/login',
      theme: ThemeData(primaryColor: Colors.orangeAccent),
      navigatorKey: Get.key,
    );
  }
}

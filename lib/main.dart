import 'package:flutter/material.dart';
import 'package:invictus/routes/main.routes.dart';

void main() {
  runApp(InvictusApp());
}


class InvictusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.getRoutes(),
      initialRoute: '/home',
    );
  }
}
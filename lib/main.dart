import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';
import 'package:invictus/routes/main.routes.dart';

void main() async {
  await initializeDateFormatting(await findSystemLocale(), null);
  runApp(InvictusApp());
}

final storage = FlutterSecureStorage();

class InvictusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.getRoutes(),
      initialRoute: '/login',
      theme: ThemeData(primaryColor: Colors.deepOrange[600]),
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
    );
  }
}

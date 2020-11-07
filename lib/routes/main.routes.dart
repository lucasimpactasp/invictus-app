import 'package:get/get.dart';
import 'package:invictus/screens/category/category.screen.dart';
import 'package:invictus/screens/home/home.screen.dart';
import 'package:invictus/screens/invoice/invoice-manager.screen.dart';
import 'package:invictus/screens/login/login.screen.dart';
import 'package:invictus/screens/products/product-manager.screen.dart';
import 'package:invictus/screens/products/product.screen.dart';
import 'package:invictus/screens/products/products.screen.dart';
import 'package:invictus/screens/user/user-manager.screen.dart';
import 'package:invictus/screens/vendor/vendor.screen.dart';

class Routes {
  static List<GetPage> getRoutes() {
    return [
      GetPage(
        name: '/login',
        page: () => Login(),
      ),
      GetPage(
        name: '/home',
        page: () => Home(),
      ),
      GetPage(
        name: '/product',
        page: () => ProductScreen(),
      ),
      GetPage(
        name: '/products',
        page: () => ProductsScreen(),
      ),
      GetPage(
        name: '/product-manager',
        page: () => ProductManager(),
      ),
      GetPage(
        name: '/invoice-manager',
        page: () => InvoiceManager(),
      ),
      GetPage(
        name: '/category-manager',
        page: () => CategoryScreen(),
      ),
      GetPage(
        name: '/vendor-manager',
        page: () => VendorScreen(),
      ),
      GetPage(
        name: '/user-manager',
        page: () => UserManagerScreen(),
      ),
    ];
  }
}

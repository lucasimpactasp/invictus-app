import 'package:get/get.dart';
import 'package:invictus/screens/category/category-manager.screen.dart';
import 'package:invictus/screens/home/home.screen.dart';
import 'package:invictus/screens/invoice/invoice-manager.screen.dart';
import 'package:invictus/screens/invoice/invoices.screen.dart';
import 'package:invictus/screens/login/login.screen.dart';
import 'package:invictus/screens/products/product-manager.screen.dart';
import 'package:invictus/screens/products/product.screen.dart';
import 'package:invictus/screens/products/products.screen.dart';
import 'package:invictus/screens/user/user-manager.screen.dart';
import 'package:invictus/screens/user/users.screen.dart';
import 'package:invictus/screens/vendor/vendor-manager.screen.dart';

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
        page: () => CategoryManagerScreen(),
      ),
      GetPage(
        name: '/vendor-manager',
        page: () => VendorManagerScreen(),
      ),
      GetPage(
        name: '/user-manager',
        page: () => UserManagerScreen(),
      ),
      GetPage(
        name: '/invoices',
        page: () => InvoicesScreen(),
      ),
      GetPage(
        name: '/users',
        page: () => UsersScreen(),
      )
    ];
  }
}

import 'package:get/get.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/services/product/product.service.dart';

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  Rx<Product> activeProduct = Product().obs;

  Future<Product> getOne(String id) async {
    final Product productRes = Product.fromJson(await productService.getOne(id));
    activeProduct.value = productRes;

    return productRes;
  }
}
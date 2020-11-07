import 'package:get/get.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/services/product/product.service.dart';

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  Rx<Product> activeProduct = Product().obs;

  Future<Product> getOne(String id) async {
    final Product productRes = await productService.getOne(id);
    activeProduct.value = productRes;

    return productRes;
  }

  Future<List<Product>> getMany() async {
    final List<Product> productsRes = await productService.getProducts();

    products.value = productsRes;

    return productsRes;
  }

  Future<List<Product>> searchProducts(String term) async {
    final List<Product> productsRes = await productService.searchProducts(term);

    products.value = productsRes;

    return productsRes;
  }

  Future<Product> updateOne(String id, Product product) async {
    final Product productRes =
        await productService.putOne(id, product.toJson());

    return productRes;
  }

  Future<Product> createProduct(Product body) async {
    final Product product = await productService.postOne(body.toJson());

    return product;
  }
}

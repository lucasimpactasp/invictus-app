import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/services/base.service.dart';

class _ProductService extends BaseService<Product> {
  String endpoint;

  _ProductService({this.endpoint = 'product'}) : super(endpoint);

  Future<List<Product>> getProducts() async {
    final response =
        await this.get('/$endpoint').catchError((error) => throw (error));

    if (response == null) {
      throw ('Error to get many from $endpoint');
    }

    final List res = response.data;

    return res.map((e) => fromJson(e)).toList();
  }

  Future<List<Product>> searchProducts(String term) async {
    final response = await this.post(
      '/$endpoint/search',
      data: {
        'term': term,
      },
    ).catchError((error) => throw (error));

    if (response == null) {
      throw ('Error to search from $endpoint');
    }

    final List res = response.data;

    return res.map((e) => fromJson(e)).toList();
  }

  @override
  Product fromJson(Map<String, dynamic> json) {
    return Product.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Product item) {
    return item.toJson();
  }
}

final productService = _ProductService();

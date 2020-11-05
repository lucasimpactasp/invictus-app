import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/services/base.service.dart';

class _ProductService extends BaseService<Product> {
  String endpoint;

  _ProductService({this.endpoint = 'product'}) : super(endpoint);

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

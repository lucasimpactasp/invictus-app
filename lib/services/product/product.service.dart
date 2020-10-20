import 'package:invictus/services/base.service.dart';

class _ProductService extends BaseService {
  String endpoint;

  _ProductService({this.endpoint = 'product'}) : super(endpoint);
}

final productService = _ProductService();

import 'package:invictus/services/base.service.dart';

class _CategoryService extends BaseService {
  String endpoint;

  _CategoryService({this.endpoint = 'category'}) : super(endpoint);
}

final categoryService = _CategoryService();

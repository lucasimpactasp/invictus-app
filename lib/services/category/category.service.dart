import 'package:invictus/core/models/category/category.model.dart';
import 'package:invictus/services/base.service.dart';

class _CategoryService extends BaseService<Category> {
  String endpoint;

  _CategoryService({this.endpoint = 'category'}) : super(endpoint);

  @override
  Category fromJson(Map<String, dynamic> json) {
    return Category.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Category item) {
    return item.toJson();
  }
}

final categoryService = _CategoryService();

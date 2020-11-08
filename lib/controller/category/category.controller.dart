import 'package:get/get.dart';
import 'package:invictus/core/models/category/category.model.dart';
import 'package:invictus/services/category/category.service.dart';

class CategoryController extends GetxController {
  RxList<Category> categories = <Category>[].obs;

  Future<List<Category>> getCategories() async {
    final categories = await categoryService.getMany();
    this.categories.value = categories;

    return categories;
  }

  Future<Category> getCategory(String id) async {
    final category = await categoryService.getOne(id);
    return category;
  }

  Future<Category> updateCategory(String id, CategoryParams body) async {
    final category = await categoryService.putOne(id, body.toJson());
    return category;
  }

  Future<Category> createCategory(CategoryParams body) async {
    final category = await categoryService.postOne(body.toJson());
    return category;
  }
}

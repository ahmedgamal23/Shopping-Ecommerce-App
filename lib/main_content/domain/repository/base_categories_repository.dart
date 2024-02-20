import '../entity/category.dart';
import '../entity/item.dart';

abstract class BaseCategoriesRepository{
  Future<List<Category>> getCategory();
  Future<List<Item>> getCategoryItem(String cateName);
}

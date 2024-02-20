import 'package:shopping_ecommerce_app/main_content/data/datasource/categories_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/category.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_categories_repository.dart';

class CategoriesRepository extends BaseCategoriesRepository{
  BaseCategoriesDatasource baseCategoriesDatasource;
  CategoriesRepository(this.baseCategoriesDatasource);
  @override
  Future<List<Category>> getCategory() async {
    return await baseCategoriesDatasource.getCategory();
  }

  @override
  Future<List<Item>> getCategoryItem(String cateName) async {
    return await baseCategoriesDatasource.getCategoryItem(cateName);
  }
}

import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_categories_repository.dart';
import '../../domain/entity/category.dart';

abstract class BaseCategoriesUseCase{
  Future<List<Category>> execute();
  Future<List<Item>> executeCategoryItems(String cateName);
}

class CategoriesUseCase extends BaseCategoriesUseCase{
  BaseCategoriesRepository baseCategoriesRepository;
  CategoriesUseCase(this.baseCategoriesRepository);
  @override
  Future<List<Category>> execute() async {
    return await baseCategoriesRepository.getCategory();
  }

  @override
  Future<List<Item>> executeCategoryItems(String cateName) async{
    return await baseCategoriesRepository.getCategoryItem(cateName);
  }
}

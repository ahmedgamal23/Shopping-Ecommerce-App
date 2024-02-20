import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';

abstract class BaseNewArrivalRepository{
  Future<List<Item>> getItemData();
}

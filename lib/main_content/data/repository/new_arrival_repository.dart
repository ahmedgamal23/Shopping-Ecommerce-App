import 'package:shopping_ecommerce_app/main_content/data/datasource/new_arrival_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_new_arrival_repository.dart';

class NewArrivalRepository extends BaseNewArrivalRepository{
  final BaseNewArrivalDatasource baseNewArrivalDatasource;
  NewArrivalRepository(this.baseNewArrivalDatasource);
  @override
  Future<List<Item>> getItemData() {
    return baseNewArrivalDatasource.getItemData();
  }
}

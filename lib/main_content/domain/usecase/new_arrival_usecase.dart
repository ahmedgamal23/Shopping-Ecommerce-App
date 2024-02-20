import 'package:shopping_ecommerce_app/main_content/domain/repository/base_new_arrival_repository.dart';

import '../entity/item.dart';

abstract class BaseNewArrivalUseCase{
  Future<List<Item>> execute();
}

class NewArrivalUseCase extends BaseNewArrivalUseCase{
  final BaseNewArrivalRepository baseNewArrivalRepository;
  NewArrivalUseCase(this.baseNewArrivalRepository);
  @override
  Future<List<Item>> execute() {
    return baseNewArrivalRepository.getItemData();
  }
}

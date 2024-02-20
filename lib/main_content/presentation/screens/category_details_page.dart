import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../component/category_details_page_body.dart';
import '../controller/bloc.dart';
import '../../data/datasource/categories_datasource.dart';
import '../../data/repository/categories_repository.dart';
import '../../domain/repository/base_categories_repository.dart';
import '../../domain/usecase/categories_usecase.dart';
import '../controller/bloc_event.dart';


class CategoryDetailsPage extends StatelessWidget {
  final String imagePath;
  final String cateName;
  const CategoryDetailsPage({super.key, required this.imagePath, required this.cateName});

  @override
  Widget build(BuildContext context) {
    BaseCategoriesDatasource baseCategoriesDatasource = CategoriesDatasource();
    BaseCategoriesRepository baseCategoriesRepository = CategoriesRepository(baseCategoriesDatasource);
    BaseCategoriesUseCase baseCategoriesUseCase = CategoriesUseCase(baseCategoriesRepository);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image(
            image: NetworkImage(
              imagePath
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                // image is loaded return image
                return child;
              } else{
                return const Center(child: CircularProgressIndicator(),);
              }
            },
            width: 40,
            height: 60
          )
        ),
        actions: const [
          Icon(Icons.card_travel),
          SizedBox(width: 20,),
        ],
      ),
      body: BlocProvider(
          create: (context) => CategoryBloc(baseCategoriesUseCase)..add(GetCategoryItemsEvent(cateName)),
        child: CategoryDetailsPageBody(cateName:cateName)
      ),
    );
  }
}


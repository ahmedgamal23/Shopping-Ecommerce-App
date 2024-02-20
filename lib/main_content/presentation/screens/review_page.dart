import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasource/review_datasource.dart';
import '../../data/repository/review_repository.dart';
import '../../domain/repository/base_review_repository.dart';
import '../../domain/usecase/review_usecase.dart';
import '../component/review_page_body.dart';
import '../controller/bloc.dart';
import '../controller/bloc_event.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    BaseReviewDatasource baseReviewDatasource = ReviewDatasource();
    BaseReviewRepository baseReviewRepository = ReviewRepository(baseReviewDatasource);
    BaseReviewUseCase baseReviewUseCase = ReviewUseCase(baseReviewRepository);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: BlocProvider(
        create: (context) => ReviewBloc(baseReviewUseCase)..add(GetAllReviewsEvent()),
        child: const ReviewPageBody()
      ),
    );
  }
}


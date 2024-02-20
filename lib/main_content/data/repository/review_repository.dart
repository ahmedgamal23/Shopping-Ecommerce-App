import 'package:shopping_ecommerce_app/main_content/data/datasource/review_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/review.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_review_repository.dart';

class ReviewRepository extends BaseReviewRepository{
  final BaseReviewDatasource baseReviewDatasource;
  ReviewRepository(this.baseReviewDatasource);
  @override
  Future<bool> addReview(Review review) async {
    return await baseReviewDatasource.addReview(review);
  }

  @override
  Future<List<Review>> getAllReviews() async {
    return await baseReviewDatasource.getAllReviews();
  }
}


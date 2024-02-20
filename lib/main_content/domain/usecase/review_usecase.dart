import 'package:shopping_ecommerce_app/main_content/domain/repository/base_review_repository.dart';
import '../entity/review.dart';

abstract class BaseReviewUseCase{
  Future<bool> executeAddReview(Review review);
  Future<List<Review>> getAllReviews();
}

class ReviewUseCase extends BaseReviewUseCase{
  final BaseReviewRepository baseReviewRepository;
  ReviewUseCase(this.baseReviewRepository);
  @override
  Future<bool> executeAddReview(Review review) async {
    return await baseReviewRepository.addReview(review);
  }

  @override
  Future<List<Review>> getAllReviews() async {
    return await baseReviewRepository.getAllReviews();
  }
}

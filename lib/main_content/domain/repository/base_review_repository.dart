import '../entity/review.dart';

abstract class BaseReviewRepository{
  Future<bool> addReview(Review review);
  Future<List<Review>> getAllReviews();
}

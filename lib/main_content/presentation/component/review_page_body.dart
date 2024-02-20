import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/review.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_state.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/add_review_page.dart';


class ReviewPageBody extends StatelessWidget {
  const ReviewPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ItemBlocState>(
      builder: (context, state) {
        List<Review> listReview = state is GetAllReviewsState?state.listReview:[];
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // total reviews and add review button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TODO: total reviews
                      Text(
                        "${listReview.length} Reviews",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // TODO: star
                      Row(
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            child: index<4?const Icon(Icons.star, size: 12,color: ConstantColor.starActiveColor,)
                                :const Icon(Icons.star, size: 12,color: ConstantColor.starUnActiveColor,),
                          );
                        }),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: (){
                      // TODO: when clicked go to add review
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddReviewPage(),));
                    },
                    style: const ButtonStyle(
                      backgroundColor:MaterialStatePropertyAll(ConstantColor.addReviewButtonColor),
                      foregroundColor: MaterialStatePropertyAll(ConstantColor.addReviewButtonTextColor),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: const Text(
                      "Add Review",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              // show all reviews
              Expanded(
                child: ListView.builder(
                  itemCount: listReview.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                listReview[index].name,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              Text("${listReview[index].stars} rating", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // time
                              Row(
                                children: [
                                  const Icon(Icons.access_time, size: 12,),
                                  const SizedBox(width: 3,),
                                  /// time
                                  Text(
                                    "${DateTime.now()}",
                                    style: const TextStyle(fontSize: 10,),
                                  ),
                                ],
                              ),
                              // stars
                              Row(
                                children: List.generate(5, (i) {
                                  return GestureDetector(
                                    child: i<listReview[index].stars?const Icon(Icons.star, size: 12,color: ConstantColor.starActiveColor,)
                                        :const Icon(Icons.star, size: 12,color: ConstantColor.starUnActiveColor,),
                                  );
                                }),
                              ),
                            ],
                          ),
                          leading: const Image(
                            image: AssetImage("assets/images/social.png",),
                            width: 40,
                            height: 40,
                          ),
                        ),
                        // body for review
                        Text(
                          listReview[index].description,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 5,),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}




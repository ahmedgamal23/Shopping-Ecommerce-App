import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import 'package:shopping_ecommerce_app/main_content/data/datasource/review_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/data/repository/review_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/review.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_review_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/review_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_event.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_state.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/review_page.dart';

class AddReviewPageBody extends StatelessWidget {
  AddReviewPageBody({super.key});

  final FocusNode _sliderFocusNode = FocusNode();
  final StreamController<double> _controllerSlider = StreamController<double>.broadcast();
  final List<TextEditingController> textEditingControllerList = List.generate(2, (index) => TextEditingController());

  Stream<double> changeSlider(){
    return _controllerSlider.stream;
  }

  @override
  Widget build(BuildContext context) {
    double starValue = 3.0;
    BaseReviewDatasource baseReviewDatasource = ReviewDatasource();
    BaseReviewRepository baseReviewRepository = ReviewRepository(baseReviewDatasource);
    BaseReviewUseCase baseReviewUseCase = ReviewUseCase(baseReviewRepository);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // form
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),
                ),
                const SizedBox(height: 5,),
                TextField(
                  controller: textEditingControllerList[0],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F6FA),
                    hintText: "Type your name",
                    hintStyle: const TextStyle(color: ConstantColor.splashContainerSubTitleColor),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white70), borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),

                const SizedBox(height: 20,),

                const Text(
                  "How was your experience ?",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),
                ),
                const SizedBox(height: 5,),
                TextField(
                  maxLines: 5,
                  controller: textEditingControllerList[1],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F6FA),
                    hintText: "Describe your experience ?",
                    hintStyle: const TextStyle(color: ConstantColor.splashContainerSubTitleColor),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white70), borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ],
            ),

            // star
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                const Text(
                  "Star",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                StreamBuilder<double>(
                  stream: changeSlider(),
                  builder: (context, snapshot) {
                    double starRateValue = snapshot.data ?? 3;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("0.0"),
                        Expanded(
                          child: Slider(
                            value: starRateValue,
                            onChanged: (value) {
                              starValue = value;
                              _controllerSlider.add(value);
                            },
                            thumbColor: ConstantColor.starThumbColor,
                            activeColor: ConstantColor.starSliderColor,
                            inactiveColor: ConstantColor.starSliderColor,
                            label: "$starRateValue",
                            min: 0,
                            max: 5,
                            focusNode: _sliderFocusNode,
                            divisions: 5,
                          ),
                        ),
                        Text("$starRateValue"),
                      ],
                    );
                  },
                ),
              ],
            ),

            BlocProvider(
              create: (context) => ReviewBloc(baseReviewUseCase),
              child: BlocConsumer<ReviewBloc, ItemBlocState>(
                listener: (context, state) {
                  bool result = state is AddReviewState?state.result:false;
                  if(result == false){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("error not add this review")));
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("added successfully")));
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ReviewPage(),));
                  }
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: (){
                      // TODO: when click on it add this review to all reviews
                      if(textEditingControllerList[0].text.trim().isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Complete fields")));
                      }
                      else{
                        BlocProvider.of<ReviewBloc>(context).add(
                            AddReviewEvent(
                                Review(
                                    name: textEditingControllerList[0].text.trim(),
                                    description: textEditingControllerList[1].text.trim(),
                                    stars: starValue
                                )
                            )
                        );
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width-50,
                      height: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ConstantColor.splashGgColor,
                      ),
                      child: const Text(
                        "Submit Review",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


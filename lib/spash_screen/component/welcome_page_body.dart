import 'package:flutter/material.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/screen/auth_options.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';

class WelcomePageBody extends StatelessWidget {
  const WelcomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // set image to background
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/sp_bg_img.jpg"),
                )
            ),
          ),
          // container select (Men or Women)
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 250,
                margin: const EdgeInsets.only(left: 25, bottom: 25),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ConstantColor.splashContainerColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Container Title
                    const Text(
                      "Look Good, Feel Good",
                      style: TextStyle(
                        color: ConstantColor.splashContainerTitleColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // Container sub title
                    const Text(
                      "Create your individual & unique style and look amazing everyday.",
                      style: TextStyle(
                        color: ConstantColor.splashContainerSubTitleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10,),
                    // select Men or Women
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Men Button
                        InkWell(
                          onTap: (){
                            // TODO: when clicked on it go to auth options and get data specially for Men
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthOptions(),));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/2-40,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF5F6FA),
                            ),
                            child: const Text(
                              "Men",
                              style: TextStyle(
                                color: ConstantColor.splashContainerSubTitleColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // Women Button
                        InkWell(
                          onTap: (){
                            // TODO: when clicked on it go to auth options and get data specially for Women
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthOptions(),));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/2-40,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFA163F9),
                            ),
                            child: const Text(
                              "Women",
                              style: TextStyle(
                                color: ConstantColor.splashTitleColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // skip button
                    TextButton(
                      onPressed: (){
                        // TODO: when click to skip button go to auth Options page
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthOptions(),));
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                            color: ConstantColor.splashContainerSubTitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 19
                        ),
                      ),
                    ),
                  ],
                ),

              ),
            ],
          ),
        ],
      ),
    );
  }
}



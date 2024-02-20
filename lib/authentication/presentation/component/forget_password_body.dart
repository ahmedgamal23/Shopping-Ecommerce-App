import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc_event.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc_state.dart';

import '../../../core/constant_color.dart';
import '../screen/verification_code_page.dart';

class ForgetPasswordBody extends StatelessWidget {
  ForgetPasswordBody({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // header
            const Text(
              "Forget Password",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Image
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/security.png"),
                  )
              ),
            ),

            // Enter your Email
            Form(
              child: TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  label: Text("Email Address"),
                  labelStyle: TextStyle(color: ConstantColor.splashContainerSubTitleColor, fontSize: 20),
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),

            // info text and confirm email button
            Column(
              children: [
                // info text
                const Text(
                  "Please write your email to receive a confirmation code to set a new password.",
                  style: TextStyle(
                    fontSize: 15,
                    color: ConstantColor.splashContainerSubTitleColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10,),
                // confirm email
                BlocConsumer<CheckEmailBloc, ResetPasswordState>(
                  listener: (context, state) {
                    // TODO: go to verification code page
                    if(state is ResetPasswordSuccess){
                      /// got to verification code
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => VerificationCodePage(
                        email: textEditingController.text.trim(),
                      ),));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("this email address ${textEditingController.text.trim()} not exist"))
                      );
                    }
                  },
                  builder: (context, state) {
                    return InkWell(
                      onTap: (){
                        // add event
                        BlocProvider.of<CheckEmailBloc>(context).add(
                          CheckEmailEvent(email: textEditingController.text.trim())
                        );
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
                          "Confirm Email",
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}


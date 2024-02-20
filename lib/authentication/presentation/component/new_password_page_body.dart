import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc_event.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc_state.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/screen/login_page.dart';
import '../../../core/constant_color.dart';

class NewPasswordPageBody extends StatelessWidget {
  final String email;
  NewPasswordPageBody({super.key, required this.email});

  final List<TextEditingController> textEditingControllerList = List.generate(2, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<NewPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          AwesomeDialog(
            context: context,
            dialogType: state is ResetPasswordSuccess?DialogType.success:DialogType.error,
            animType: AnimType.rightSlide,
            title: state is ResetPasswordSuccess?"password is successfully reset":"Failed to reset password",
            btnOkOnPress: () {
              if(state is ResetPasswordSuccess){
                // TODO: go to Login page
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage(),));
              }else if(state is ResetPasswordFailure){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to reset password")));
              }
            },
          ).show();
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // header
                const Text(
                  "New Password",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // write password
                Form(
                  child: Column(
                    children: [
                      createTextFormField("Password", true, textEditingControllerList[0]),
                      createTextFormField("Confirm Password", true, textEditingControllerList[1]),
                    ],
                  ),
                ),

                // text and reset password button
                Column(
                  children: [
                    // note text
                    const Text(
                      "Please write your new password.",
                      style: TextStyle(
                        fontSize: 16,
                        color: ConstantColor.splashContainerSubTitleColor,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    // reset password button
                    InkWell(
                      onTap: (){
                        if(textEditingControllerList[0].text.trim()=="" || textEditingControllerList[0].text.trim()==""){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("write password")));
                        }else if(textEditingControllerList[0].text.trim() != textEditingControllerList[0].text.trim()){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("write correct password")));
                        }else{
                          // TODO: go to login page
                          BlocProvider.of<NewPasswordBloc>(context).add(
                              NewPasswordEvent(
                                  email: email,
                                  password: textEditingControllerList[1].text.trim(),
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
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget createTextFormField(String labelName, bool obscureText, TextEditingController textEditingController){
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        label: Text(labelName),
        labelStyle: const TextStyle(color: ConstantColor.splashContainerSubTitleColor, fontSize: 20),
      ),
      obscureText: obscureText,
      style: const TextStyle(fontSize: 20),
    );
  }
}



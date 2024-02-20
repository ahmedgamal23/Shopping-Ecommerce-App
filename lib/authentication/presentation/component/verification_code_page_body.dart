import 'dart:async';
import 'dart:ffi';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc_event.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc_state.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import '../screen/new_password_page.dart';


class VerificationCodePageBody extends StatefulWidget {
  final String email;
  const VerificationCodePageBody({super.key, required this.email});

  @override
  State<VerificationCodePageBody> createState() => _VerificationCodePageBodyState();
}

class _VerificationCodePageBodyState extends State<VerificationCodePageBody> {
  int secondRemaining = 60;
  late Timer timer;
  bool clickResend = false;
  List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(secondRemaining > 0) {
          secondRemaining = secondRemaining-1;
        }else{
          if(clickResend)
          {
            secondRemaining=60;
            clickResend=false;
          }else{
            timer.cancel();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String minutes = (secondRemaining ~/ 60).toString().padLeft(2, '0');
    String seconds = (secondRemaining % 60).toString().padLeft(2, '0');
    bool result = false;

    return Center(
      child: BlocConsumer<CheckCodeBloc, ResetPasswordState>(
        listener: (context, state) {
          AwesomeDialog(
            context: context,
            dialogType: state is ResetPasswordSuccess?DialogType.success:DialogType.error,
            animType: AnimType.rightSlide,
            title: state is ResetPasswordSuccess?"Verification code is successfully":"the verification code not match",
            btnOkOnPress: () {
              if(state is ResetPasswordSuccess){
                // TODO: go to New Password Page
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewPasswordPage(email: widget.email),));
              }else if(state is ResetPasswordFailure){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("the verification code not match")));
              }else{
                result = true;
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
                  "Verification Code",
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

                // verification code and timer
                Column(
                  children: [
                    // enter verification code
                    createTextEditingVerificationCode(),
                    const SizedBox(height: 20,),
                    // timer
                    Text(
                      "$minutes:$seconds",
                      style: const TextStyle(
                        color: ConstantColor.splashContainerTitleColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),

                // resend code text and confirm code button
                Column(
                  children: [
                    // resend code after 60s
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // timer to resend code
                        InkWell(
                          onTap: (){
                            // when clicked resend code
                            BlocProvider.of<ResendCodeBloc>(context).add(
                                ResendCodeEvent(email: widget.email)
                            );
                            setState(() {
                              clickResend=true;
                              startTimer();
                            });
                          },
                          child: const Text(
                            "resend",
                            style: TextStyle(
                              color: ConstantColor.splashGgColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const Text(
                          " confirmation code.",
                          style: TextStyle(
                            color: ConstantColor.splashContainerSubTitleColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Confirm Code
                    InkWell(
                      onTap: (){
                        // add event
                        String code = "";
                        for(int i=0;i<controllers.length;i++){
                          code += controllers[i].text.trim();
                        }
                        if(code == "" || code.length < 4){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter verification code")));
                        }else{
                          BlocProvider.of<CheckCodeBloc>(context).add(
                              CheckCodeEvent(code: int.parse(code))
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
                          "Confirm Code",
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

  Widget createTextEditingVerificationCode(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) {
          return Container(
            width: 50,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: controllers[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: const InputDecoration(
                hintText: '_',
                counterText: '',
              ),
              onChanged: (value) {
                if(value.length == 1 && value.length < 3){
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/authentication_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/auth_bloc_event.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/auth_bloc_state.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/screen/login_page.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CreateNewAccountBody extends StatelessWidget {
  CreateNewAccountBody({super.key});

  final _formKey = GlobalKey<FormState>();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  final List<TextEditingController> textEditingControllerList = List.generate(3, (index) => TextEditingController());

  Stream<bool> changeSwitchValue(){
    return _controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    bool result = false;
    return Center(
      child: BlocConsumer<CreateNewAccountBloc, AuthenticationState>(
        listener: (context, state) {
          AwesomeDialog(
            context: context,
            dialogType: state is AuthenticationSuccess?DialogType.success:DialogType.error,
            animType: AnimType.rightSlide,
            title: state is AuthenticationSuccess?"register successfully":"Failed to register",
            btnOkOnPress: () {
              if(state is AuthenticationSuccess){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage(),));
              }else if(state is AuthenticationFailure){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to register")));
              }else{
                result = true;
              }
            },
          ).show();
        },
        builder: (context, state) {
          bool checkSwitch = false;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // header
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 100,),

                  // form
                  Column(
                    children: [
                      // register new user
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // username
                            createTextFormField("Username", false, textEditingControllerList[0]),
                            const SizedBox(height: 15,),
                            // password
                            createTextFormField("Email", false, textEditingControllerList[1]),
                            const SizedBox(height: 15,),
                            // email
                            createTextFormField("Password", true, textEditingControllerList[2]),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      // toggle button for remember me
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Remember me",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          StreamBuilder(
                            stream: changeSwitchValue(),
                            initialData: false,
                            builder: (context, snapshot) {
                              return Switch(
                                value: snapshot.data!,
                                onChanged: (value) {
                                  checkSwitch = value;
                                  _controller.add(value);
                                },
                                activeColor: const Color(0xFF32CA5B),
                                thumbColor: const MaterialStatePropertyAll(Colors.white),
                                inactiveTrackColor: Colors.black12,
                                trackOutlineColor: const MaterialStatePropertyAll(Colors.black12),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 100,),
                  // Sign up
                  InkWell(
                    onTap: (){
                      // TODO: go to login page to continue
                      if(!_formKey.currentState!.validate())
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Complete data')),
                        );
                      }else{
                        BlocProvider.of<CreateNewAccountBloc>(context).add(
                            CreateNewAccountEvent(
                                userName: textEditingControllerList[0].text.trim(),
                                email: textEditingControllerList[1].text.trim(),
                                password: textEditingControllerList[2].text.trim(),
                                rememberMe: checkSwitch
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
                      child: result==false?const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ):const CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget createTextFormField(String labelName, bool obscureText, TextEditingController textEditingController){
    return TextFormField(
      controller: textEditingController,
      validator: (value) {
        if(value!.isEmpty){
          return "please complete fields";
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(labelName),
        labelStyle: const TextStyle(color: ConstantColor.splashContainerSubTitleColor, fontSize: 20),
        suffixIcon: const Icon(Icons.add, color: Colors.greenAccent,),
      ),
      obscureText: obscureText,
      style: const TextStyle(fontSize: 20),
    );
  }
}


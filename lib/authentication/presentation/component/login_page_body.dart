import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/auth_bloc_event.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/auth_bloc_state.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/authentication_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/screen/create_new_account.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/screen/forget_password.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import '../../../main_content/presentation/screens/main_page.dart';

class LoginPageBody extends StatelessWidget {
  LoginPageBody({super.key});

  final _formKey = GlobalKey<FormState>();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  final List<TextEditingController> textEditingControllerList = List.generate(5, (index) => TextEditingController());

  Stream<bool> changeSwitchValue(){
    return _controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    bool checkSwitch = false;
    return Center(
      child: BlocConsumer<LoginBloc, AuthenticationState>(
        listener: (context, state) {
          AwesomeDialog(
            context: context,
            dialogType: state is AuthenticationSuccess?DialogType.success:DialogType.error,
            animType: AnimType.rightSlide,
            title: state is AuthenticationSuccess?"login successfully":"Failed to login",
            btnOkOnPress: () {
              if(state is AuthenticationSuccess){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage(),));
              }else if(state is AuthenticationFailure){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to login")));
              }else{
                // loading

              }
            },
          ).show();
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // header
                      const Column(
                        children: [
                          // header
                          Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // sub header
                          Text(
                            "Please enter your data to continue",
                            style: TextStyle(
                              color: ConstantColor.splashContainerSubTitleColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50,),

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
                                createTextFormField("Password", true, textEditingControllerList[1]),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20,),
                          // Forget Password
                          InkWell(
                            onTap: (){
                              // TODO: when click go to forget password page
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgetPassword(),));
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: const Text(
                                "Forget Password?",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                ),
                              ),
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
                      const SizedBox(height: 50,),

                      // footer
                      Column(
                        children: [
                          const Text(
                            "By connecting your account confirm that you agree with our Term and Condition",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: ConstantColor.splashContainerSubTitleColor,
                            ),
                          ),

                          TextButton(
                            onPressed: (){
                              // TODO: when clicked on it go to register page
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateNewAccount(),));
                            },
                            child: const Text(
                                "if you don't have an account, register now"
                            ),
                          ),

                          const SizedBox(height: 20,),
                          // login button
                          InkWell(
                            onTap: (){
                              // TODO: go to main page
                              if(_formKey.currentState!.validate()){
                                BlocProvider.of<LoginBloc>(context).add(
                                    LoginEvent(
                                        userName: textEditingControllerList[0].text.trim(),
                                        password: textEditingControllerList[1].text.trim(),
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
                              child: const Text(
                                "Login",
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
                ),
              ),
              state is AuthenticationLoading?const Center(child: CircularProgressIndicator(),):Container(),
            ],
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


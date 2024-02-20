import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/authentication_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/auth_bloc_event.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/auth_bloc_state.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/screen/create_new_account.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/screen/login_page.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/main_page.dart';

class AuthOptionsBody extends StatelessWidget {
  const AuthOptionsBody({super.key});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // header
          const Text(
            "Let’s Get Started",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),

          // login with (Facebook, twitter ( X ) , Google)
          Column(
            children: [
              /// Facebook button
              createButton(context, ConstantColor.splashFacebookBgColor, "assets/images/facebook.png", "Facebook", SignInWithFacebookEvent()),
              const SizedBox(height: 15,),
              /// Google button
              createButton(context, ConstantColor.splashGoogleBgColor, "assets/images/social.png", "Google", SignInWithGoogleEvent()),
            ],
          ),

          // sign in or create new account
          Column(
            children: [
              // if already have an account go to sign in page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 16,
                      color: ConstantColor.splashContainerSubTitleColor,
                    ),
                  ),
                  // link
                  TextButton(
                    onPressed: (){
                      // TODO: when click it go to sign in
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage(),));
                    },
                    child: const Text(
                      "Signin",
                      style: TextStyle(
                        fontSize: 16,
                        color: ConstantColor.splashContainerTitleColor,
                      ),
                    ),
                  ),
                ],
              ),
              // create new account
              InkWell(
                onTap: (){
                  // TODO: go to create new account
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateNewAccount(),));
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
                    "Create an Account",
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
  }

  Widget createButton(BuildContext context, Color bgColor, String imgName , String text, AuthenticationEvent event) {
    return BlocBuilder<AuthBloc, AuthenticationState>(
      builder: (context, state) {
        bool check = false;
        return InkWell(
          onTap: (){
            // TODO: when user clicked add event
            BlocProvider.of<AuthBloc>(context).add(event);
            /// check
            if(state is AuthenticationSuccess){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage(),));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sign in successfully"), duration: Duration(seconds: 2),));
            }else if(state is AuthenticationFailure){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sign in Failed"), duration: Duration(seconds: 2),));
            }else if(state is AuthenticationLoading){
              check = true;
            }
          },
          child: check==true?const Center(child: CircularProgressIndicator()):Container(
            width: MediaQuery.of(context).size.width-50,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: bgColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgName),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/screen/forget_password.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/user_info_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/user_info_bloc_state.dart';

import '../../../core/constant_color.dart';

class ShowPasswordPageBody extends StatelessWidget {
  const ShowPasswordPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                if(state is UserInfoSuccess){
                  return Form(
                    child: Column(
                      children: [
                        // username
                        createTextFormField("Username", false, state.user.username),
                        const SizedBox(height: 15,),
                        // email
                        createTextFormField("Email", false, state.user.email),
                        const SizedBox(height: 15,),
                        // password
                        createTextFormField("Password", false, state.user.password!),
                      ],
                    ),
                  );
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }
              },
            ),
            // login button
            InkWell(
              onTap: (){
                // TODO: update password
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ForgetPassword() ,));
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
                  "Update Password",
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
      ),
    );
  }

  Widget createTextFormField(String labelName, bool obscureText, String value){
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        label: Text(labelName),
        labelStyle: const TextStyle(color: ConstantColor.splashContainerSubTitleColor, fontSize: 20),
      ),
      obscureText: obscureText,
      style: const TextStyle(fontSize: 20),
    );
  }

}


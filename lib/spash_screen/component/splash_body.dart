import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import 'package:shopping_ecommerce_app/spash_screen/controllers/preference_bloc.dart';
import 'package:shopping_ecommerce_app/spash_screen/controllers/preference_bloc_state.dart';
import '../../main_content/presentation/screens/main_page.dart';
import '../screens/welcome_page.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: BlocConsumer<PreferenceBloc, PreferenceState>(
        listenWhen: (previous, current) => previous != current,
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if(state is PreferenceSuccess){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage(),));
          }else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WelcomePage(),));
          }
        },
        builder: (context, state) {
          return const Text(
            "Shopping",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: ConstantColor.splashTitleColor,
            ),
          );
        },
      ),
    );
  }
}


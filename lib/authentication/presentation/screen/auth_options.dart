import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/authentication_bloc.dart';
import '../component/auth_options_body.dart';

class AuthOptions extends StatelessWidget {
  const AuthOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: const AuthOptionsBody()
      ),
    );
  }
}


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/firebase_options.dart';
import 'package:shopping_ecommerce_app/spash_screen/controllers/preference_bloc.dart';
import 'package:shopping_ecommerce_app/spash_screen/controllers/preference_bloc_event.dart';
import 'package:shopping_ecommerce_app/spash_screen/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'core/constant_color.dart';
import 'main_content/presentation/controller/theme_provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'shopping ecommerce app',
            debugShowCheckedModeBanner: false,
            color: ConstantColor.splashGgColor,
            theme: value.isDarkMode?ThemeData.dark():ThemeData.light(),
            home: BlocProvider(
              create: (context) => PreferenceBloc()..add(CheckSharedPreferenceEvent()),
              child: const SplashScreen()
            ),
          );
        },
      ),
    );
  }
}

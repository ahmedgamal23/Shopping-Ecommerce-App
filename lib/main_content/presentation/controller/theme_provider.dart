import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{
  bool isDarkMode = false;

  ThemeProvider(){
    loadThemeMode();
  }

  Future<void> loadThemeMode()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isDarkMode = sharedPreferences.getBool("isDarkMode") ?? false;
  }

  Future<void> saveThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  void toggleTheme(){
    isDarkMode = !isDarkMode;
    saveThemeMode();
    notifyListeners();
  }
}

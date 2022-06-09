/*
* File : App Theme Notifier (Listener)
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
// import 'package:flutx/themes/app_theme.dart';
// import 'package:flutx/themes/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeNotifier extends ChangeNotifier {
  static int _themeMode = 1;
  static int theme = 1;

  AppThemeNotifier() {
    init();
  }

  init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? data = sharedPreferences.getInt("themeMode");
    if (data == null) {
      _themeMode = 1;
      theme = 1;
    } else {
      _themeMode = data;
      theme = data;
    }

    // _changeTheme(_themeMode);
    notifyListeners();
  }

  themeMode() => _themeMode;

  Future<void> updateTheme(int themeMode) async {
    AppThemeNotifier._themeMode = themeMode;
    AppThemeNotifier.theme = themeMode;

    // _changeTheme(themeMode);

    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("themeMode", themeMode);
  }

  // _changeTheme(int themeMode){
  //   AppTheme.customTheme = AppTheme.getCustomAppTheme(themeMode);
  //   AppTheme.theme = AppTheme.getThemeFromThemeMode(themeMode);

  //   if(themeMode==1){
  //     FxAppTheme.changeThemeType(FxAppThemeType.light);
  //     FxCustomTheme.changeThemeType(FxCustomThemeType.light);
  //   }else if(themeMode==2){
  //     FxAppTheme.changeThemeType(FxAppThemeType.dark);
  //     FxCustomTheme.changeThemeType(FxCustomThemeType.dark);
  //   }

}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../theme/theme_config.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc() : super(AppState(ThemeConfig.lightTheme));
  ThemeData theme = ThemeConfig.lightTheme;
  Key? key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setKey(value) {
    key = value;
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
  }

  // change the Theme in the provider and SharedPreferences
  void setTheme(value, c) async {
    theme = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', c);
    emit(AppState(theme));
  }

  ThemeData getTheme(value) {
    return theme;
  }

  Future<ThemeData> checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeData t;
    String r = prefs.getString('theme') ?? 'light';

    if (r == 'light') {
      t = ThemeConfig.lightTheme;
      setTheme(ThemeConfig.lightTheme, 'light');
    } else {
      t = ThemeConfig.darkTheme;
      setTheme(ThemeConfig.darkTheme, 'dark');
    }

    return t;
  }
}

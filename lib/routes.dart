import 'package:flutter/material.dart';

import 'screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/login/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
};

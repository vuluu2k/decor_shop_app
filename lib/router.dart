import 'package:flutter/material.dart';
import 'package:shop/features/auth/screens/auth_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const AuthScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                  body: Center(
                child: Text("Oh no! Màn hình không tồn tại!"),
              )));
  }
}

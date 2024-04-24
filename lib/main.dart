import 'package:flutter/material.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/auth/screens/auth_screen.dart';
import 'package:shop/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DecorApp',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              primary: GlobalVariables.secondaryColor),
          useMaterial3: true,
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          appBarTheme: const AppBarTheme(
            // color: GlobalVariables.appBarGradient,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          )),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AuthScreen(),
    );
  }
}

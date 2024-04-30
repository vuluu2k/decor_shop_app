import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/common/widgets/bottom_bar.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/auth/screens/auth_screen.dart';
import 'package:shop/features/auth/services/auth_service.dart';
import 'package:shop/providers/user_provider.dart';
import 'package:shop/router.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    print('initState called');
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Decor',
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
      home: !Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const BottomBar()
          : const BottomBar(),
    );
  }
}

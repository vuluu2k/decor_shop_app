import 'package:flutter/material.dart';
import 'package:shop/common/widgets/bottom_bar.dart';
import 'package:shop/features/auth/screens/auth_screen.dart';
import 'package:shop/features/home/screens/home_screen.dart';
import 'package:shop/features/product/screens/product_screen.dart';
import 'package:shop/models/product.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const BottomBar(),
      );
    case ProductScreen.routeName:
      var product = settings.arguments as Product;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => ProductScreen(product: product),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Oh no! Màn hình không tồn tại!"),
          ),
        ),
      );
  }
}

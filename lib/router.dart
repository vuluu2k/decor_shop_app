import 'package:flutter/material.dart';
import 'package:shop/common/widgets/bottom_bar.dart';
import 'package:shop/features/auth/screens/auth_screen.dart';
import 'package:shop/features/cart/screens/cart_screen.dart';
import 'package:shop/features/category/screen/category_screen.dart';
import 'package:shop/features/home/screens/home_screen.dart';
import 'package:shop/features/product/screens/product_screen.dart';
import 'package:shop/models/category.dart';
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
    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const CartScreen(),
      );
    case CategoryScreen.routeName:
      var category = settings.arguments as Category;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => CategoryScreen(category: category),
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

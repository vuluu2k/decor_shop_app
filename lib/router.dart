import 'package:flutter/material.dart';
import 'package:shop/common/widgets/bottom_bar.dart';
import 'package:shop/features/account/screens/info_screen.dart';
import 'package:shop/features/auth/screens/auth_screen.dart';
import 'package:shop/features/bill/screen/bill_screen.dart';
import 'package:shop/features/bill/screen/order_screen.dart';
import 'package:shop/features/cart/screens/cart_screen.dart';
import 'package:shop/features/category/screens/category_screen.dart';
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
    case OrderScreen.routeName:
      var products = settings.arguments as List<ProductQuantity>;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => OrderScreen(products: products),
      );
    case BillScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const BillScreen(),
      );
    case InfoScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const InfoScreen(),
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

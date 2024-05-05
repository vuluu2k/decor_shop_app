import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/common/widgets/bottom_bar.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/auth/screens/auth_screen.dart';
import 'package:shop/features/auth/services/auth_service.dart';
import 'package:shop/features/bill/services/bill_service.dart';
import 'package:shop/features/cart/services/cart_service.dart';
import 'package:shop/features/favorite/services/favorite_service.dart';
import 'package:shop/features/home/services/category_service.dart';
import 'package:shop/features/home/services/product_service.dart';
import 'package:shop/providers/bill_provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/category_provider.dart';
import 'package:shop/providers/favorite_provider.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/providers/user_provider.dart';
import 'package:shop/router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => CategoryProvider()),
    ChangeNotifierProvider(create: (context) => ProductProvider()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => FavoriteProvider()),
    ChangeNotifierProvider(create: (context) => BillProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  final CategoryService categoryService = CategoryService();
  final ProductService productService = ProductService();
  final CartService cartService = CartService();
  final FavoriteService favoriteService = FavoriteService();
  final BillService billService = BillService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
    categoryService.getCategories(context: context);
    // productService.getProducts(context: context);
    cartService.getCart(context: context);
    favoriteService.getFavorite(context: context);
    billService.getBills(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Decor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: GlobalVariables.selectedNavBarColor,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: GlobalVariables.selectedNavBarColor,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.id == -1
          ? const AuthScreen()
          : const BottomBar(),
    );
  }
}

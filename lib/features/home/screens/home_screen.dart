import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/common/widgets/cart_button.dart';
import 'package:shop/common/widgets/product_list.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/home/services/product_service.dart';
import 'package:shop/features/home/widgets/carousels.dart';
import 'package:shop/features/home/widgets/categories.dart';
import 'package:shop/providers/product_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductService productService = ProductService();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    productService.getProducts(context: context);
  }

  void getProducts(search) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      productService.getProducts(context: context, search: search);
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;
    const borderSearchRadius = 4.0;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: Material(
                    borderRadius: BorderRadius.circular(borderSearchRadius),
                    shadowColor: Colors.transparent,
                    elevation: 1,
                    child: TextFormField(
                      onChanged: getProducts,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: GlobalVariables.backgroundColor,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(borderSearchRadius),
                          ),
                          borderSide: BorderSide(
                            color: GlobalVariables.selectedNavBarColor,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(borderSearchRadius),
                          ),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        hintText: 'Tìm kiếm',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const CartButton(),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Carousels(),
            const Categories(),
            const SizedBox(height: 10),
            ProductList(
              products: products,
            ),
          ],
        ),
      ),
    );
  }
}

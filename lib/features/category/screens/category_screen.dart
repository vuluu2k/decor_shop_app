import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/common/widgets/cart_button.dart';
import 'package:shop/common/widgets/product_list.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/home/services/product_service.dart';
import 'package:shop/models/category.dart';
import 'package:shop/providers/product_provider.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/category-screen';
  final Category category;
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
    productService.getProducts(
      context: context,
      idDecorType: widget.category.id,
    );
  }

  void getProducts(search) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      productService.getProducts(
        context: context,
        idDecorType: widget.category.id,
        search: search,
      );
    });
  }

  @protected
  @mustCallSuper
  void didPopNext(Route<dynamic> nextRoute) {
    print('in here');
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).productsCategory;
    const borderSearchRadius = 4.0;
    return Scaffold(
      appBar: AppBar(
        title: Row(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: ProductList(products: products),
            ),
          ],
        ),
      ),
    );
  }
}

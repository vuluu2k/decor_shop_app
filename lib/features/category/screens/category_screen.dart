import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/common/widgets/product_list.dart';
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
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
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

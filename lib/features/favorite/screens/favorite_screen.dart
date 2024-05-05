import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/common/widgets/cart_button.dart';
import 'package:shop/common/widgets/product_list.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/favorite_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoriteProvider>(context).favorites;
    final products = Products(
      content: List<Product>.from(favorites.content.map((f) {
        return f.decor;
      }).toList()),
      totalElements: favorites.totalElements,
      totalPages: favorites.totalPages,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sản phám yêu thích'),
            CartButton(),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: ProductList(products: products),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/common/widgets/product_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/product_provider.dart';

class ProductList extends StatelessWidget {
  final Products products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.content.isEmpty) {
      return const Center(child: Text('Chưa có sản phẩm nào!'));
    }

    return Wrap(
      spacing: 10.0, // gap between adjacent chips
      runSpacing: 10.0, // gap between lines
      children: products.content.map(
        (product) {
          return ProductItem(
            product: product,
            name: product.name,
            image: product.image,
            price: product.price,
          );
        },
      ).toList(),
    );
  }
}

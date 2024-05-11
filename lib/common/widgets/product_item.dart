import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/product/screens/product_screen.dart';
import 'package:shop/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final String name;
  final String image;
  final double price;
  const ProductItem({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductScreen.routeName,
          arguments: product,
        );
      },
      child: SizedBox(
        width: 180,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0.5, 0.5), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Image.network(
                image,
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text(
                  '₫$price',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProductOrderItem extends StatelessWidget {
  final String image;
  const ProductOrderItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 1.5),
              borderRadius: BorderRadius.circular(4),
              color: Colors.white),
          child: Container(
            width: 180,
            padding: const EdgeInsets.all(10),
            child: Image.network(
              image,
              fit: BoxFit.fitHeight,
              width: 180,
            ),
          ),
        ));
  }
}

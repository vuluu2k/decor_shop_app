import 'package:flutter/material.dart';
import 'package:shop/features/cart/screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.pushNamed(context, CartScreen.routeName);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: const Badge(
          backgroundColor: Color.fromARGB(255, 238, 77, 45),
          label: Text('1'),
          child: Icon(
            Icons.shopping_cart_outlined,
            size: 25,
          ),
        ),
      ),
    );
  }
}

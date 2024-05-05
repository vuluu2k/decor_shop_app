import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/features/cart/screens/cart_screen.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/providers/cart_provider.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Cart> carts = Provider.of<CartProvider>(context).carts;

    void onTap() {
      Navigator.pushNamed(context, CartScreen.routeName);
    }

    int totalQuantity = 0;
    for (var cart in carts) {
      totalQuantity += cart.number;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Badge(
          backgroundColor: Color.fromARGB(255, 238, 77, 45),
          label: Text('$totalQuantity'),
          child: const Icon(
            Icons.shopping_cart_outlined,
            size: 25,
          ),
        ),
      ),
    );
  }
}

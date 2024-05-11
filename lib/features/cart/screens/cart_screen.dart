import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/common/widgets/count_item.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/bill/screen/order_screen.dart';
import 'package:shop/features/cart/services/cart_service.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart-screen';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Cart> carts = Provider.of<CartProvider>(context).carts;
    final CartService cartService = CartService();

    double totalPrice = 0;
    for (var cart in carts) {
      totalPrice += cart.decor.price * cart.number;
    }

    void onUpdateCart(int idCart, int idDecor, int number) {
      cartService.updateCart(
        context: context,
        idCart: idCart,
        idDecor: idDecor,
        number: number,
      );
    }

    void buyProduct() {
      Navigator.pushNamed(
        context,
        OrderScreen.routeName,
        arguments: carts.map((c) {
          return ProductQuantity(product: c.decor, quantity: c.number);
        }).toList(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: carts.isEmpty
          ? const Center(
              child: Text('Không có sản phẩm nào trong giỏ hàng'))
          : Column(
              children: [
                for (var cart in carts)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          cart.decor.image,
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  cart.decor.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₫${cart.decor.price}',
                                    style: const TextStyle(
                                      color:
                                          GlobalVariables.selectedNavBarColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  CountItem(
                                    count: cart.number,
                                    onDecrease: () {
                                      onUpdateCart(
                                        cart.id,
                                        cart.decor.id,
                                        cart.number - 1,
                                      );
                                    },
                                    onIncrease: () {
                                      onUpdateCart(
                                        cart.id,
                                        cart.decor.id,
                                        cart.number + 1,
                                      );
                                    },
                                    min: 1,
                                    max: 10000,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ],
            ),
      bottomSheet: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Tổng thanh toán'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '₫$totalPrice',
                      style: const TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: buyProduct,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                  child: const Text(
                    'Mua hàng',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

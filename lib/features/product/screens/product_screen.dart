import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/common/widgets/cart_button.dart';
import 'package:shop/common/widgets/count_item.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/bill/screen/order_screen.dart';
import 'package:shop/features/cart/services/cart_service.dart';
import 'package:shop/models/product.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = '/product-screen';
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final CartService cartService = CartService();

  void buyNow() {
    Navigator.pushNamed(
      context,
      OrderScreen.routeName,
      arguments: [ProductQuantity(product: widget.product, quantity: 1)],
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product.name,
            ),
            const CartButton()
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Image.network(
              '$uriImage${product.image}',
              alignment: Alignment.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '₫${product.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: GlobalVariables.selectedNavBarColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Còn ${product.quantity} sản phẩm',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Mô tả sản phẩm',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Text(
                  product.descriptionDecor,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      int count = product.quantity > 0 ? 1 : 0;

                      return StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          void decrementCount() {
                            if (count > 1) {
                              setState(() {
                                count--;
                              });
                            }
                          }

                          void incrementCount() {
                            setState(() {
                              count++;
                            });
                          }

                          void addToCart() {
                            cartService.addToCart(
                              context: context,
                              idDecor: product.id,
                              quantity: count,
                              onSuccess: () {
                                Navigator.pop(context);
                              },
                            );
                          }

                          return SizedBox(
                            height: 150,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                  right: 10,
                                  bottom: 0,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Số lượng:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        CountItem(
                                          count: count,
                                          min: 1,
                                          max: product.quantity,
                                          onDecrease: decrementCount,
                                          onIncrease: incrementCount,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: InkWell(
                                        onTap: addToCart,
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            color: GlobalVariables
                                                .selectedNavBarColor,
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: const Text(
                                            'Thêm giỏ hàng',
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
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.cyan[600]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Thêm giỏ hàng',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: buyNow,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                  child: const Text(
                    'Mua hàng ngay',
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

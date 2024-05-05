import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/bill/services/order_service.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/user.dart';
import 'package:shop/providers/user_provider.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = '/order-screen';
  final List<ProductQuantity> products;
  const OrderScreen({super.key, required this.products});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  double totalPrice = 0;
  final TextEditingController _addressController = TextEditingController();
  final OrderService orderService = OrderService();
  @override
  void initState() {
    super.initState();
    totalPrice = calcTotalPrice();
  }

  double calcTotalPrice() {
    double total = 0;
    for (var product in widget.products) {
      total += product.product.price * product.quantity;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).user;
    bool orderLoading = false;

    void orderNow() async {
      setState(() {
        orderLoading = true;
      });
      showDialog(
        context: context,
        useSafeArea: true,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SpinKitFoldingCube(
                      color: Colors.white,
                      size: 30.0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Đang xử lý...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
      await orderService.createOrder(
        context: context,
        products: widget.products,
        address: _addressController.text.isEmpty
            ? user.address
            : _addressController.text,
        onSuccess: () {
          setState(() {
            orderLoading = false;
            Navigator.pop(context);
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 2,
                ),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: GlobalVariables.selectedNavBarColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                    'Đơn hàng sẽ được giao tới ${user.fullName} tại ${user.address}'),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Text(
              'Danh sách sản phẩm',
              style: TextStyle(
                color: GlobalVariables.selectedNavBarColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          for (var product in widget.products)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Image.network(
                    '$uriImage${product.product.image}',
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.product.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₫${product.product.price}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'x${product.quantity}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Phương thức thanh toán:'),
                Text('Thanh toán khi nhận hàng')
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    'Không nhập mặc định lấy địa chỉ đăng ký tài khoản',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  child: TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      hintText: 'Nhập địa chỉ',
                      hintStyle: TextStyle(fontSize: 14),
                    ),
                    selectionHeightStyle: BoxHeightStyle.tight,
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
              flex: 2,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Tổng thanh toán'),
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
                onTap: orderNow,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                  child: const Text(
                    'Đặt hàng',
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

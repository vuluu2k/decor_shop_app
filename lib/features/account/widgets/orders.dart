import 'package:flutter/material.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/account/widgets/product_order_item.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [
    {
      "id": 1,
      "image":
          "https://images.unsplash.com/photo-1714227667692-df498d9b5943?q=80&w=3435&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "id": 2,
      "image":
          "https://plus.unsplash.com/premium_photo-1713840471972-c0e7f2813383?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMnx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "id": 3,
      "image":
          "https://images.unsplash.com/photo-1714227667692-df498d9b5943?q=80&w=3435&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              padding: EdgeInsets.only(left: 15),
              child: const Text("Đơn hàng của bạn",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600))),
          Container(
              padding: EdgeInsets.only(right: 15),
              child: TextButton(
                  onPressed: () {},
                  child: Text("Xem tất cả",
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ))))
        ]),
        Container(
            height: 170,
            padding:
                const EdgeInsets.only(left: 10, top: 20, right: 0, bottom: 0),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ProductOrderItem(image: list[index]["image"]);
                }))
      ],
    );
  }
}

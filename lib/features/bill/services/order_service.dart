import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/constants/utils.dart';
import 'package:shop/models/product.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<void> createOrder({
    required BuildContext context,
    required List<ProductQuantity> products,
    required String address,
    required VoidCallback onSuccess,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? userId = prefs.getString('user_id');

      http.Response resBill = await http.post(
        Uri.parse('$uri/api/bill/post'),
        body: jsonEncode({
          'idUser': userId,
          'total': calcTotalPrice(products),
          'methodPayment': 0,
          'status': 1,
          'address': address,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      if (resBill.statusCode == 200) {
        List<http.Response> resProducts = await Future.wait(
          products.map(
            (product) async {
              return await http.post(
                Uri.parse('$uri/api/bill-detail/post'),
                body: jsonEncode({
                  'idDecor': product.product.id,
                  'idBill': jsonDecode(resBill.body)['id'],
                  'number': product.quantity,
                }),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer $token'
                },
              );
            },
          ),
        );
        showSnackBar(context, 'Đặt hàng thành công');
        onSuccess();
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

double calcTotalPrice(List<ProductQuantity> products) {
  double total = 0;
  for (var product in products) {
    total += product.product.price * product.quantity;
  }

  return total;
}

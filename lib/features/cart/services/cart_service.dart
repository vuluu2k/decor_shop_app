import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/cart_provider.dart';

class CartService {
  void addToCart({
    required BuildContext context,
    required int idDecor,
    required int quantity,
    required VoidCallback onSuccess,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? userId = prefs.getString('user_id');

      http.Response res = await http.post(
        Uri.parse('$uri/api/cart/post'),
        body: jsonEncode({
          'idDecor': idDecor,
          'number': quantity,
          'idUser': userId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        await getCart(context: context);
        showSnackBar(context, 'Đã thêm vào giỏ hàng');
        onSuccess();
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getCart({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) return;

      String? userId = prefs.getString('user_id');

      http.Response res = await http.get(
        Uri.parse('$uri/api/cart/get/cartbyuser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        var cartProvider = Provider.of<CartProvider>(context, listen: false);
        cartProvider.setCarts(res.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> updateCart({
    required BuildContext context,
    required int idCart,
    required int idDecor,
    required int number,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? userId = prefs.getString('user_id');

      http.Response res = await http.put(
        Uri.parse('$uri/api/cart/put/$idCart'),
        body: jsonEncode({
          'idDecor': idDecor,
          'idUser': userId,
          'number': number,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        await getCart(context: context);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

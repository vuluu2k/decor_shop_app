import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/constants/utils.dart';
import 'package:http/http.dart' as http;

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
          'decorId': idDecor,
          'number': quantity,
          'userId': userId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        showSnackBar(context, 'Đã thêm vào giỏ hàng');
        onSuccess();
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getCart({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? userId = prefs.getString('user_id');

      http.Response res = await http.get(
        Uri.parse('$uri/api/cart/get/page'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print(res.statusCode);
      print(res.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

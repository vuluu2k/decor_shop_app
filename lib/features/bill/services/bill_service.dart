import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/bill_provider.dart';

class BillService {
  Future<void> getBills({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) return;

      String? userId = prefs.getString('user_id');

      http.Response res = await http.get(
        Uri.parse('$uri/api/bill/get/page?filter=idUser:$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        var billProvider = Provider.of<BillProvider>(context, listen: false);
        billProvider.setBills(res.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

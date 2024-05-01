import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/product_provider.dart';

class ProductService {
  void getProducts({required BuildContext context}) async {
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/decor/get/page'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      var productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.setProducts(res.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/category_provider.dart';

class CategoryService {
  void getCategories({required BuildContext context}) async {
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/decor-type/get/page'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      var categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      categoryProvider.setCategories(res.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

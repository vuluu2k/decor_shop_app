import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/product_provider.dart';

class ProductService {
  Future<void> getProducts({
    required BuildContext context,
    int? idDecorType,
    String? search,
  }) async {
    try {
      var termString = '', isHasFilter = false;
      if (idDecorType != null) {
        termString = "filter=idDecorType:$idDecorType";
        isHasFilter = true;
      }

      if (search != null) {
        if (termString.isEmpty) {
          termString = "filter=name~'*$search*'";
        } else {
          termString = "$termString&filter=name~'*$search*'";
        }

        isHasFilter = true;
      }

      print('$uri/api/decor/get/page${isHasFilter ? "?$termString" : ""}');

      http.Response res = await http.get(
        Uri.parse(
            '$uri/api/decor/get/page${isHasFilter ? "?$termString" : ""}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      var productProvider =
          Provider.of<ProductProvider>(context, listen: false);

      if (res.statusCode == 200) {
        if (idDecorType == null) {
          productProvider.setProducts(res.body);
        } else {
          productProvider.setProductsCategory(res.body);
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

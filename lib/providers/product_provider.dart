import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductProvider extends ChangeNotifier {
  Products _products = Products(
    content: List<Product>.empty(),
    totalElements: 0,
    totalPages: 0,
  );

  Products get products => _products;

  void setProducts(String products) {
    _products = Products.fromJson(products);
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> _carts = List<Cart>.empty();

  List<Cart> get carts => _carts;

  void setCarts(String carts) {
    _carts = List<Cart>.from(jsonDecode(carts).map((x) => Cart.fromMap(x)));
    notifyListeners();
  }
}

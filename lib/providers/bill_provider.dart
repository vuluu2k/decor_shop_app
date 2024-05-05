import 'package:flutter/material.dart';
import 'package:shop/models/bill.dart';

class BillProvider with ChangeNotifier {
  Bills _bills = Bills(
    content: List<Bill>.empty(),
    totalElements: 0,
    totalPages: 0,
  );

  Bills get bills => _bills;

  void setBills(String bills) {
    _bills = Bills.fromJson(bills);
    notifyListeners();
  }
}

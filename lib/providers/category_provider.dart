import 'package:flutter/material.dart';
import 'package:shop/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  Categories _categories = Categories(
    content: List<Category>.empty(),
    totalPages: 0,
    totalElements: 0,
  );

  Categories get categories => _categories;

  void setCategories(String categories) {
    _categories = Categories.fromJson(categories);
    notifyListeners();
  }
}

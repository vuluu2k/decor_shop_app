import 'package:flutter/material.dart';
import 'package:shop/models/favorite.dart';

class FavoriteProvider extends ChangeNotifier {
  Favorites _favorites = Favorites(
    content: List<Favorite>.empty(),
    totalPages: 0,
    totalElements: 0,
  );

  Favorites get favorites => _favorites;

  void setFavorites(String favorites) {
    _favorites = Favorites.fromJson(favorites);
    notifyListeners();
  }
}

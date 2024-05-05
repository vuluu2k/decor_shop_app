// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shop/models/product.dart';

class Favorite {
  final int id;
  final String modifiedDate;
  final String createdDate;
  final int idDecor;
  final Product decor;

  Favorite({
    required this.id,
    required this.modifiedDate,
    required this.createdDate,
    required this.idDecor,
    required this.decor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'modifiedDate': modifiedDate,
      'createdDate': createdDate,
      'idDecor': idDecor,
      'decor': decor.toMap(),
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id']?.toInt() ?? -1,
      modifiedDate: map['modifiedDate']?.toString() ?? '',
      createdDate: map['createdDate']?.toString() ?? '',
      idDecor: map['idDecor']?.toInt() ?? -1,
      decor: Product.fromMap(map['decor'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) =>
      Favorite.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Favorites {
  final List<Favorite> content;
  final int totalPages;
  final int totalElements;

  Favorites({
    required this.content,
    required this.totalPages,
    required this.totalElements,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content.map((x) => x.toMap()).toList(),
      'totalPages': totalPages,
      'totalElements': totalElements,
    };
  }

  factory Favorites.fromMap(Map<String, dynamic> map) {
    return Favorites(
      content: List<Favorite>.from(
        (map['content'] as List).map<Favorite>(
          (x) => Favorite.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalPages: map['totalPages']?.toInt() ?? 0,
      totalElements: map['totalElements']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorites.fromJson(String source) =>
      Favorites.fromMap(json.decode(source) as Map<String, dynamic>);
}

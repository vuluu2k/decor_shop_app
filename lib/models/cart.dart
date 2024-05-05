// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shop/models/product.dart';
import 'package:shop/models/user.dart';

class Cart {
  final int id;
  final String modifiedDate;
  final String createdDate;
  final bool deleted;
  final int idDecor;
  final Product decor;
  final int number;

  Cart({
    required this.id,
    required this.modifiedDate,
    required this.createdDate,
    required this.deleted,
    required this.idDecor,
    required this.decor,
    required this.number,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'modifiedDate': modifiedDate,
      'createdDate': createdDate,
      'deleted': deleted,
      'idDecor': idDecor,
      'decor': decor.toMap(),
      'number': number,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id']?.toInt() ?? -1,
      modifiedDate: map['modifiedDate']?.toString() ?? '',
      createdDate: map['createdDate']?.toString() ?? '',
      deleted: map['deleted'] ?? false,
      idDecor: map['idDecor']?.toInt() ?? -1,
      decor: Product.fromMap(map['decor'] as Map<String, dynamic>),
      number: map['number']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);
}

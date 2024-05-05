// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shop/models/category.dart';

class Product {
  final int id;
  final String modifiedDate;
  final String createdDate;
  final int idDecorType;
  final Category decorType;
  final String name;
  final String image;
  final String descriptionDecor;
  final double price;
  final int quantity;
  final int status;

  Product({
    required this.id,
    required this.modifiedDate,
    required this.createdDate,
    required this.idDecorType,
    required this.decorType,
    required this.name,
    required this.image,
    required this.descriptionDecor,
    required this.price,
    required this.quantity,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'modifiedDate': modifiedDate,
      'createdDate': createdDate,
      'idDecorType': idDecorType,
      'decorType': decorType.toMap(),
      'name': name,
      'image': image,
      'descriptionDecor': descriptionDecor,
      'price': price,
      'quantity': quantity,
      'status': status,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      modifiedDate: map['modifiedDate']?.toString() ?? '',
      createdDate: map['createdDate']?.toString() ?? '',
      idDecorType: map['idDecorType'] ?? 0,
      decorType: Category.fromMap(map['decorType']),
      name: map['name']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      descriptionDecor: map['descriptionDecor']?.toString() ?? '',
      price: map['price']?.toDouble() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Products {
  final List<Product> content;
  final int totalElements;
  final int totalPages;

  Products({
    required this.content,
    required this.totalElements,
    required this.totalPages,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content.map((x) => x.toMap()).toList(),
      'totalElements': totalElements,
      'totalPages': totalPages,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      content: List<Product>.from(
        (map['content'] as List).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalElements: map['totalElements'] as int,
      totalPages: map['totalPages'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) =>
      Products.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductQuantity {
  final Product product;
  final int quantity;

  ProductQuantity({required this.product, required this.quantity});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory ProductQuantity.fromMap(Map<String, dynamic> map) {
    return ProductQuantity(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductQuantity.fromJson(String source) =>
      ProductQuantity.fromMap(json.decode(source) as Map<String, dynamic>);
}

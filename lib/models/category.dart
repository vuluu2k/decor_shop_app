import 'dart:convert';

class Category {
  final int id;
  final String modifiedDate;
  final String createdDate;
  final bool deleted;
  final String name;
  final String image;
  final int status;

  Category({
    required this.id,
    required this.modifiedDate,
    required this.createdDate,
    required this.deleted,
    required this.name,
    required this.image,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'modifiedDate': modifiedDate,
      'createdDate': createdDate,
      'deleted': deleted,
      'name': name,
      'image': image,
      'status': status,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id']?.toInt() ?? '',
      modifiedDate: map['modifiedDate']?.toString() ?? '',
      createdDate: map['createdDate']?.toString() ?? '',
      deleted: map['deleted'] ?? false,
      name: map['name']?.toString() ?? '',
      image: map['image']?.toString() ??
          'https://down-vn.img.susercontent.com/file/687f3967b7c2fe6a134a2c11894eea4b_tn',
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Categories {
  final List<Category> content;
  final int totalPages;
  final int totalElements;

  Categories({
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

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      content: List<Category>.from(
        (map['content'] as List).map<Category>(
          (x) => Category.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalPages: map['totalPages'] as int,
      totalElements: map['totalElements'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Categories.fromJson(String source) =>
      Categories.fromMap(json.decode(source) as Map<String, dynamic>);
}

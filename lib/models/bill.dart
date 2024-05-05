// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Bill {
  final int id;
  final String modifiedDate;
  final String createdDate;
  final double total;
  final int methodPayment;
  final int status;
  final String address;

  Bill({
    required this.id,
    required this.modifiedDate,
    required this.createdDate,
    required this.total,
    required this.methodPayment,
    required this.status,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'modifiedDate': modifiedDate,
      'createdDate': createdDate,
      'total': total,
      'methodPayment': methodPayment,
      'status': status,
      'address': address,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id']?.toInt() ?? -1,
      modifiedDate: map['modifiedDate']?.toString() ?? '',
      createdDate: map['createdDate']?.toString() ?? '',
      total: map['total']?.toDouble() ?? 0,
      methodPayment: map['methodPayment']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      address: map['address']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Bill.fromJson(String source) =>
      Bill.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Bills {
  final List<Bill> content;
  final int totalElements;
  final int totalPages;

  Bills({
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

  factory Bills.fromMap(Map<String, dynamic> map) {
    return Bills(
      content: List<Bill>.from(
        (map['content'] as List).map<Bill>(
          (x) => Bill.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalElements: map['totalElements']?.toInt() ?? 0,
      totalPages: map['totalPages']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bills.fromJson(String source) =>
      Bills.fromMap(json.decode(source) as Map<String, dynamic>);
}

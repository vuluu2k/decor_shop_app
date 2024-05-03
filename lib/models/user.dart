// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final int id;
  final String modifiedDate;
  final String createdDate;
  final bool deleted;
  final String email;
  final String fullName;
  final String password;
  final int role;
  final bool gioiTinh;
  final String address;
  final String sdt;
  final String avatar;
  final int status;

  User({
    required this.id,
    required this.modifiedDate,
    required this.createdDate,
    required this.deleted,
    required this.email,
    required this.fullName,
    required this.password,
    required this.role,
    required this.gioiTinh,
    required this.address,
    required this.sdt,
    required this.avatar,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'modifiedDate': modifiedDate,
      'createdDate': createdDate,
      'deleted': deleted,
      'email': email,
      'fullName': fullName,
      'password': password,
      'role': role,
      'gioiTinh': gioiTinh,
      'address': address,
      'sdt': sdt,
      'avatar': avatar,
      'status': status,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? -1,
      modifiedDate: map['modifiedDate']?.toString() ?? '',
      createdDate: map['createdDate']?.toString() ?? '',
      deleted: map['deleted'] ?? false,
      email: map['email']?.toString() ?? '',
      fullName: map['fullName']?.toString() ?? '',
      password: map['password']?.toString() ?? '',
      role: map['role']?.toInt() ?? 0,
      gioiTinh: map['gioiTinh'] ?? false,
      address: map['address']?.toString() ?? '',
      sdt: map['sdt']?.toString() ?? '',
      avatar: map['avatar']?.toString() ?? '',
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'package:flutter/material.dart';
import 'package:shop/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: -1,
    modifiedDate: '',
    createdDate: '',
    deleted: false,
    email: '',
    fullName: '',
    password: '',
    role: 1,
    gioiTinh: true,
    address: '',
    sdt: '',
    avatar: '',
    status: 1,
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void resetUser() {
    _user = User(
      id: -1,
      modifiedDate: '',
      createdDate: '',
      deleted: false,
      email: '',
      fullName: '',
      password: '',
      role: 1,
      gioiTinh: true,
      address: '',
      sdt: '',
      avatar: '',
      status: 1,
    );
    notifyListeners();
  }
}

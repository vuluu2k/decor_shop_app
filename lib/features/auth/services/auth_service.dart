// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/common/widgets/bottom_bar.dart';
import 'package:shop/constants/error_handing.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/constants/utils.dart';
import 'package:shop/features/auth/screens/auth_screen.dart';
import 'package:shop/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/user_provider.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String name,
    required String phone,
    required String password,
    required String rePassword,
    required String address,
    required VoidCallback onSuccess,
  }) async {
    try {
      if (password != rePassword) {
        showSnackBar(context, "Mật khẩu nhập lại không chính xác!");
        return;
      }

      User user = User(
        id: -1,
        modifiedDate: '',
        createdDate: '',
        deleted: false,
        email: email,
        fullName: name,
        password: password,
        role: 1,
        gioiTinh: true,
        address: address,
        sdt: phone,
        avatar: '',
        status: 1,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/nguoi-dung/create'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Tạo tài khoản thành công!");
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/nguoi-dung/login'),
        body: jsonEncode({'username': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', jsonDecode(res.body)['result']);
          await prefs.setString(
            'user_id',
            jsonDecode(res.body)['user']['userId'].toString(),
          );

          getUserData(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? userId = prefs.getString('user_id');

      if (token == null) return;

      http.Response res = await http.get(
        Uri.parse('$uri/api/nguoi-dung/get/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      if (res.statusCode == 200) {
        Provider.of<UserProvider>(context, listen: false)
            .setUser(jsonEncode(jsonDecode(res.body)['data'][0]));
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void changePassword({
    required BuildContext context,
    required String password,
    required String rePassword,
    required VoidCallback onSuccess,
  }) async {
    try {
      if (password != rePassword) {
        showSnackBar(context, "Mật khẩu không khớp!");
        return;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      http.Response res = await http.post(
        Uri.parse('$uri/api/nguoi-dung/change-password'),
        body: jsonEncode({'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      if (res.statusCode == 200) {
        showSnackBar(context, 'Đổi mật khẩu thành công!');
        onSuccess();
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> updateUser({
    required BuildContext context,
    required String name,
    required String phone,
    required String address,
    required VoidCallback onSuccess,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? userId = prefs.getString('user_id');

      http.Response res = await http.put(
        Uri.parse('$uri/api/nguoi-dung/put/$userId'),
        body: jsonEncode(
          {
            'fullName': name,
            'sdt': phone,
            'address': address,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      if (res.statusCode == 200) {
        getUserData(context);
        showSnackBar(context, 'Cập nhật thành công!');
        onSuccess();
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> forgotPassword({
    required BuildContext context,
    required String email,
    required String password,
    required String rePassword,
    required VoidCallback onSuccess,
  }) async {
    try {
      print({email, password, rePassword});
      if (password != rePassword) {
        showSnackBar(context, "Mật khẩu nhập lại không chính xác!");
        return;
      }

      http.Response res = await http.post(
        Uri.parse('$uri/api/nguoi-dung/forgot-password'),
        body: jsonEncode({'username': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, 'Đổi mật khẩu thành công!');
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> logout({
    required BuildContext context,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user_id');

    Provider.of<UserProvider>(context, listen: false).resetUser();
  }
}

import 'package:flutter/material.dart';
import 'package:shop/constants/error_handing.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/constants/utils.dart';
import 'package:shop/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          email: email,
          name: name,
          password: password,
          address: '',
          type: '',
          token: '');

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      print(user.toJson());

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Account created! Login with the same credent");
        },
      );
      print(res.statusCode);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

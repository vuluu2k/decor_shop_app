import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/favorite_provider.dart';

class FavoriteService {
  Future<void> getFavorite({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) return;

      String? userId = prefs.getString('user_id');
      http.Response res = await http.get(
        Uri.parse('$uri/api/favorite/page?filter=idUser:$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        var favoriteProvider =
            Provider.of<FavoriteProvider>(context, listen: false);
        favoriteProvider.setFavorites(res.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> addToFavorite({
    required BuildContext context,
    required int idDecor,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? userId = prefs.getString('user_id');

      http.Response res = await http.post(Uri.parse('$uri/api/favorite/post'),
          body: jsonEncode({
            'idDecor': idDecor,
            'idUser': userId,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });

      print('add');
      print(res.body);
      if (res.statusCode == 200) {
        await getFavorite(context: context);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> removeFromFavorite({
    required BuildContext context,
    required int idDecor,
    required int idFavorite,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? userId = prefs.getString('user_id');

      http.Response res = await http.delete(
        Uri.parse('$uri/api/favorite/del/$idFavorite'),
        body: jsonEncode({
          'idDecor': idDecor,
          'idUser': userId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print('remove');
      print(res.statusCode);
      if (res.statusCode == 200) {
        await getFavorite(context: context);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

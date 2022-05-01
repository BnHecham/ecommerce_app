import 'package:dio/dio.dart';
import 'package:ecommerce_app/src/config/route.dart';
import 'package:ecommerce_app/src/model/data.dart';
import 'package:ecommerce_app/src/model/user.dart';
import 'package:ecommerce_app/src/pages/shop_pages/main_page.dart';
import 'package:flutter/material.dart';

import '../services/api/api_services.dart';
import '../widgets/buildSnakeBar.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  ExtractUser? user = ExtractUser();
  Token _userToken =Token();



  Future<void> signIn(BuildContext context ,{required String email , required String password}) async {
    Response response = await _apiService.post(AppData.baseUrl+'login',
        body: {'email': email, 'password': password},);
    if (response.statusCode == 200) {
      _userToken = Token.fromJson(response.data);
      pushReplacement(MainPages(index: 0,));
    }else if( response.statusCode == 401 ){
      ScaffoldMessenger.of(context).showSnackBar(
          snackBar(content: "Unauthorized user!"));
    }
    notifyListeners();
  }

  Future<void> getUser() async {
    _apiService.get(AppData.baseUrl + "user" ,
        headers: {'Authorization':'Bearer ${_userToken.token}'}).then((response) {
      if (response.statusCode == 200) {
        user = ExtractUser.fromJson(response.data);
        notifyListeners();
      }
    });
  }
}
import 'package:dio/dio.dart';
import 'package:ecommerce_app/src/model/failure.dart';

import 'package:flutter/material.dart';

import '../config/route.dart';
import '../model/data.dart';
import '../model/user.dart';
import '../pages/user_pages/signInScreen.dart';
import '../services/api/api_services.dart';
import '../widgets/buildSnakeBar.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  Failure _failure = Failure();
  Token _token = Token();


  signUp(BuildContext context,{required String name , required String email , required String password}) async {
    Response response = await _apiService.post(AppData.baseUrl+'register',
        body: {'name': name, 'email': email, 'password': password});
    if (response.statusCode == 201) {
      _token = Token.fromJson(response.data);
      pushReplacement(const SignInScreen());
    }
    else if (response.statusCode == 422){
      _failure = Failure.fromJson(response.data);
      ScaffoldMessenger.of(context).showSnackBar(
          snackBar(content: _failure.errors!.email![0]));
    }
    notifyListeners();
  }
}
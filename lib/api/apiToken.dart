import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lectoya/screens/Inicio/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends Interceptor {
  final BuildContext context;

  TokenInterceptor(this.context);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _handleUnauthorized();
    }
    super.onError(err, handler);
  }

  Future<void> _handleUnauthorized() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    await prefs.remove('token');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginVentana()),
      (route) => false,
    );
  }
}

import 'package:clothes_store_app/services/api_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isloading = false;
  String? _errorMessage;

  bool get isloading => _isloading;
  String? get errorMessage => _errorMessage;

  Future<bool> register(String name, String email, String password) async {
    _isloading = true;
    _errorMessage = null;
    notifyListeners();
    final sucess = await Apiservice.register(name, email, password);
    _isloading = false;
    if (!sucess) _errorMessage = "Email already is used";
    notifyListeners();
    return sucess;
  }

    Future<bool> login(String email, String password) async {
    _isloading = true;
    _errorMessage = null;
    notifyListeners();
    final token = await Apiservice.login( email, password);
    _isloading = false;
    if (token==null) _errorMessage = "Invalid email or password";
    notifyListeners();
    return token!=null;
  }
}

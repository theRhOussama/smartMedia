import 'package:flutter/material.dart';
import 'package:smartmedia/models/user.dart';
import 'package:smartmedia/ressources/auth_method.dart';

class UserProvider with ChangeNotifier{
    User? _user;
  final AuthMethods _authMethods = AuthMethods();
  User? get getUser=>_user;

  Future<void> refresh() async{
    User user = await _authMethods.getUserDetails();
    _user=user;
    print(_user);
    notifyListeners();
  }

}
import 'dart:convert';

import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class Auth {
  User get loggedInUser;
  Future<void> loginUser(String id, String password);
  Future<void> logoutUser();
  Future<User> getUser(String id);
}

class AuthService with ChangeNotifier implements Auth {
  User _user;

  User get loggedInUser => _user;

  Future<void> loginUser(String id, String password) async {
    if (int.parse(id) > 0 && int.parse(id) < 11) {
      User user = await getUser(id);
      _user = user;
    }
    notifyListeners();
  }

  Future<void> logoutUser() async {
    _user = null;
    notifyListeners();
  }

  Future<User> getUser(String id) async {
    final res = await http.get('$apiUrl/users/$id');
    return User.fromJson(json.decode(res.body) as Map<String, dynamic>);
  }
}

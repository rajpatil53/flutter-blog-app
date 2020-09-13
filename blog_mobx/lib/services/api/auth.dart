import 'dart:convert';

import 'package:blog_mobx/app/constants.dart';
import 'package:blog_mobx/models/user.dart';
import 'package:http/http.dart' as http;

abstract class Auth {
  Future<User> loginUser(String id, String password);
  Future<User> getUser(String id);
}

class AuthService implements Auth {
  Future<User> loginUser(String id, String password) async {
    if (int.parse(id) > 0 && int.parse(id) < 11) {
      User user = await getUser(id);
      return user;
    }
    return null;
  }

  Future<User> getUser(String id) async {
    final res = await http.get('$apiUrl/users/$id');
    return User.fromJson(json.decode(res.body) as Map<String, dynamic>);
  }
}

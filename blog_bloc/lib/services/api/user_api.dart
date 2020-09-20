import 'dart:convert';

import 'package:blog_bloc/app/constants.dart';
import 'package:blog_bloc/models/user.dart';
import 'package:http/http.dart' as http;

abstract class UserService {
  Future<User> getUser(String id);
}

class UserServiceImpl implements UserService {
  Future<User> getUser(String id) async {
    final res = await http.get('$apiUrl/users/$id');
    User user = User.fromJson(json.decode(res.body) as Map<String, dynamic>);
    return user;
  }
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:blog_bloc/app/constants.dart';
import 'package:blog_bloc/models/user.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(NotLoggedIn());

  Future<void> login(String id, String password) async {
    emit(LoggingIn());
    if (int.parse(id) > 0 && int.parse(id) < 11) {
      User user = await getUser(id);
      emit(LoggedIn(user));
    }
  }

  Future<void> logoutUser() async {
    emit(NotLoggedIn());
  }

  Future<User> getUser(String id) async {
    final res = await http.get('$apiUrl/users/$id');
    return User.fromJson(json.decode(res.body) as Map<String, dynamic>);
  }
}

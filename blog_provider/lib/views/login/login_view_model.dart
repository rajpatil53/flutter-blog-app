import 'package:blog_provider/models/user.dart';
import 'package:blog_provider/services/api/auth.dart';
import 'package:blog_provider/views/base_view_model.dart';
import 'package:flutter/material.dart';
import '../../app/constants.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService auth;

  LoginViewModel({this.auth});

  Future<void> login(String id, String pw) async {
    changeViewState(ViewState.Busy);
    await auth.loginUser(id, pw);
    changeViewState(ViewState.Idle);
  }
}

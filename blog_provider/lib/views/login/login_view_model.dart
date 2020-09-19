import 'package:blog_provider/services/api/user.dart';
import 'package:blog_provider/views/base_view_model.dart';
import 'package:flutter/material.dart';
import '../../app/constants.dart';

class LoginViewModel extends BaseViewModel {
  final UserServiceImpl auth;

  LoginViewModel({this.auth});

  Future<void> login(String id, String pw, BuildContext ctx) async {
    changeViewState(ViewState.Busy);
    try {
      await auth.loginUser(id, pw);
    } catch (err) {
      print(err);
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text('Login failed. '),
      ));
    }
    changeViewState(ViewState.Idle);
  }
}

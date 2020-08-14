import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/services/api/auth.dart';
import 'package:blog_provider/views/base_view.dart';
import 'package:blog_provider/views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

part 'login_view.g.dart';

@hwidget
Widget loginView(BuildContext context) {
  final TextEditingController _idController =
      useTextEditingController(text: '1');
  final TextEditingController _pwController =
      useTextEditingController(text: 'password');

  return BaseView<LoginViewModel>(
    model: LoginViewModel(auth: Provider.of<AuthService>(context)),
    builder: (_, viewModel, __) => Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.grey.shade500,
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.grey.shade500,
                filled: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            viewModel.state == ViewState.Busy
                ? CircularProgressIndicator()
                : MaterialButton(
                    onPressed: () {
                      viewModel.login(_idController.text, _pwController.text);
                    },
                    color: Colors.grey.shade800,
                    textColor: Colors.white,
                    child: Text('Login'),
                  )
          ],
        ),
      ),
    ),
  );
}

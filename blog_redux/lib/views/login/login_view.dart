import 'package:blog_redux/views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'login_view.g.dart';

@hwidget
Widget loginView(BuildContext context, LoginViewModel model) {
  final TextEditingController _idController =
      useTextEditingController(text: '1');
  final TextEditingController _pwController =
      useTextEditingController(text: 'password');

  // final AuthCubit auth = BlocProvider.of<AuthCubit>(context);

  return Scaffold(
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
          model.loading
              ? CircularProgressIndicator()
              : MaterialButton(
                  onPressed: () =>
                      model.login(_idController.text, _pwController.text),
                  color: Colors.grey.shade800,
                  textColor: Colors.white,
                  child: Text('Login'),
                ),
        ],
      ),
    ),
  );
}

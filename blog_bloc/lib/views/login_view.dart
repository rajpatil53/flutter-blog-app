import 'package:blog_bloc/blocs/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'login_view.g.dart';

@hwidget
Widget loginView(BuildContext context) {
  final TextEditingController _idController =
      useTextEditingController(text: '1');
  final TextEditingController _pwController =
      useTextEditingController(text: 'password');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  return Scaffold(
    key: _scaffoldKey,
    body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _idController,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _pwController,
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (_, state) => state is LoggingIn
                ? CircularProgressIndicator()
                : MaterialButton(
                    onPressed: () => BlocProvider.of<AuthCubit>(context)
                        .login(_idController.text, _pwController.text),
                    child: Text('Login'),
                  ),
          ),
        ],
      ),
    ),
  );
}

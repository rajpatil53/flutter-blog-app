import 'package:flutter/material.dart';

final String apiUrl = 'https://jsonplaceholder.typicode.com';

class RoutePaths {
  static const String Login = '/login';
  static const String Home = '/';
  static const String Post = '/posts';
}

enum ViewState { Busy, Idle }

final TextTheme textTheme = TextTheme(
  headline1: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  headline2: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  headline3: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
  bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
  bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
);

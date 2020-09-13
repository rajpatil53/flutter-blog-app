import 'package:blog_mobx/app/constants.dart';
import 'package:blog_mobx/models/post.dart';
import 'package:blog_mobx/views/post_view.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RoutePaths.Login:
      //   return MaterialPageRoute(builder: (_) => LoginView());
      // case RoutePaths.Home:
      //   return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.Post:
        var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => PostView(post));
    }
  }
}

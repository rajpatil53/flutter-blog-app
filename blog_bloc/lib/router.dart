import 'package:blog_bloc/views/home_view.dart';
import 'package:blog_bloc/views/login_view.dart';
import 'package:blog_bloc/views/post_view.dart';
import 'package:flutter/material.dart';

import 'app/constants.dart';
import 'models/post.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.Post:
        var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => PostView(post));
    }
  }
}

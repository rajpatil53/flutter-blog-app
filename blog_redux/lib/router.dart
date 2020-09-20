import 'package:blog_redux/store/actions/actions.dart';
import 'package:blog_redux/views/home/home_view.dart';
import 'package:blog_redux/views/home/home_view_model.dart';
import 'package:blog_redux/views/posts/post_view.dart';
import 'package:blog_redux/views/posts/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'app/constants.dart';
import 'models/app_state.dart';
import 'models/post.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RoutePaths.Login:
      //   return MaterialPageRoute(builder: (_) => LoginView());
      // case RoutePaths.Home:
      //   return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.Post:
        var post = settings.arguments as Post;
        return MaterialPageRoute(
          builder: (_) => StoreConnector<AppState, PostViewModel>(
            onInit: (store) =>
                store.dispatch(FetchCommentsForPost(post.id.toString())),
            converter: (store) => PostViewModel.create(store),
            builder: (_, model) => PostView(post, model),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => HomeView(HomeViewModel()));
    }
  }
}

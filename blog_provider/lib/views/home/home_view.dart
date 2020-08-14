import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/models/user.dart';
import 'package:blog_provider/services/api/auth.dart';
import 'package:blog_provider/services/api/post_service.dart';
import 'package:blog_provider/views/base_view.dart';
import 'package:blog_provider/views/home/home_view_model.dart';
import 'package:blog_provider/views/widgets/post_list.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

part 'home_view.g.dart';

@hwidget
Widget homeView(BuildContext context) {
  final User _user = Provider.of<AuthService>(context).loggedInUser;

  return BaseView(
    model: HomeViewModel(
      auth: Provider.of<AuthService>(context),
      postService: Provider.of<PostService>(context),
    ),
    onModelReady: (model) {
      model.getPosts(_user.id.toString());
    },
    builder: (_, model, __) => Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi ${_user.name.split(' ')[0]}',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () => model.logout(),
          )
        ],
      ),
      body: model.state == ViewState.Busy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PostList(model.posts),
    ),
  );
}

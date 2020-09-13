import 'package:blog_mobx/app/constants.dart';
import 'package:blog_mobx/models/user.dart';
import 'package:blog_mobx/state/user_store.dart';
import 'package:blog_mobx/state/post_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:blog_mobx/widgets/post_list.dart';
import 'package:provider/provider.dart';

part 'home_view.g.dart';

@hwidget
Widget homeView(BuildContext context) {
  final UserStore userStore = Provider.of<UserStore>(context);
  final PostStore postStore = Provider.of<PostStore>(context);
  final User _user = userStore.loggedInUser;

  useEffect(() {
    postStore.getAllPosts();
    return () {};
  }, []);

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Hi ${_user.name.split(' ')[0]}',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.power_settings_new),
          onPressed: () => userStore.logoutUser(),
        )
      ],
    ),
    body: Observer(
      builder: (_) => postStore.viewState == ViewState.Busy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PostList(postStore.posts),
    ),
  );
}

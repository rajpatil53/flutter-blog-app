import 'package:blog_mobx/app/constants.dart';
import 'package:blog_mobx/models/post.dart';
import 'package:blog_mobx/state/user_store.dart';
import 'package:blog_mobx/state/post_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:blog_mobx/widgets/comments.dart';
import 'package:provider/provider.dart';

part 'post_view.g.dart';

@hwidget
Widget postView(BuildContext context, Post _post) {
  final UserStore userStore = Provider.of<UserStore>(context);
  final PostStore postStore = Provider.of<PostStore>(context);

  useEffect(() {
    postStore.getCommentsForPost(_post.id.toString());

    return () {};
  }, []);

  return Scaffold(
    appBar: AppBar(
      title: Text(userStore.loggedInUser.name),
    ),
    body: Column(
      children: <Widget>[
        Text(_post.title),
        Divider(),
        Text(_post.body),
        Divider(),
        Observer(
          builder: (_) => postStore.commentsViewState == ViewState.Busy
              ? CircularProgressIndicator()
              : Expanded(child: Comments(postStore.comments)),
        ),
      ],
    ),
  );
}

import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/models/post.dart';
import 'package:blog_provider/services/api/auth.dart';
import 'package:blog_provider/services/api/post_service.dart';
import 'package:blog_provider/views/base_view.dart';
import 'package:blog_provider/views/post/post_view_model.dart';
import 'package:blog_provider/views/widgets/comments.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

part 'post_view.g.dart';

@hwidget
Widget postView(BuildContext context, Post _post) {
  return BaseView<PostViewModel>(
    model: PostViewModel(postService: Provider.of<PostService>(context)),
    onModelReady: (model) => model.fetchComments(_post.id),
    builder: (_, model, __) => Scaffold(
      appBar: AppBar(
        title: Text(
            Provider.of<AuthService>(context, listen: false).loggedInUser.name),
      ),
      body: Column(
        children: <Widget>[
          Text(_post.title),
          Divider(),
          Text(_post.body),
          Divider(),
          model.state == ViewState.Busy
              ? CircularProgressIndicator()
              : Expanded(child: Comments(model.comments)),
        ],
      ),
    ),
  );
}

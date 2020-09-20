import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/models/post.dart';
import 'package:blog_provider/services/api/user.dart';
import 'package:blog_provider/services/api/post_service.dart';
import 'package:blog_provider/views/base_view.dart';
import 'package:blog_provider/views/post/post_view_model.dart';
import 'package:blog_provider/views/widgets/comments.dart';
import 'package:blog_provider/views/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

part 'post_view.g.dart';

@hwidget
Widget postView(BuildContext context, Post _post) {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  return BaseView<PostViewModel>(
    model: PostViewModel(
      postService: Provider.of<PostService>(context),
      userService: Provider.of<UserService>(context),
      post: _post,
    ),
    onModelReady: (model) => model.fetchComments(_post.id, _scaffoldKey),
    builder: (_, model, __) => Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
            Provider.of<UserService>(context, listen: false).loggedInUser.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _post.title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                LikeButton(
                  isLiked: model.isLiked,
                  onClickHandler: model.likeButtonHandler,
                ),
              ],
            ),
            Divider(),
            Text(
              _post.body,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Divider(),
            model.state == ViewState.Busy
                ? CircularProgressIndicator()
                : Expanded(child: Comments(model.comments)),
          ],
        ),
      ),
    ),
  );
}

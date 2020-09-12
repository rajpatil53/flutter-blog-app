import 'package:blog_redux/models/post.dart';
import 'package:blog_redux/views/posts/post_view_model.dart';
import 'package:blog_redux/widgets/comments.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'post_view.g.dart';

@hwidget
Widget postView(BuildContext context, Post post, PostViewModel model) {
  useEffect(() {
    // BlocProvider.of<CommentBloc>(context)
    //     .add(FetchCommentsForPost(_post.id.toString()));

    return () {};
  }, []);

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Hi ${model.loggedInUser.name.split(' ')[0]}',
      ),
    ),
    body: Column(
      children: <Widget>[
        Text(post.title),
        Divider(),
        Text(post.body),
        Divider(),
        model.loading
            ? CircularProgressIndicator()
            : Expanded(child: Comments(model.comments)),
      ],
    ),
  );
}

import 'package:blog_bloc/models/post.dart';
import 'package:blog_bloc/services/auth/cubit/auth_cubit.dart';
import 'package:blog_bloc/services/comments/bloc/comment_bloc.dart';
import 'package:blog_bloc/services/post/bloc/post_bloc.dart';
import 'package:blog_bloc/widgets/comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

part 'post_view.g.dart';

@hwidget
Widget postView(BuildContext context, Post _post) {
  useEffect(() {
    BlocProvider.of<CommentBloc>(context)
        .add(FetchCommentsForPost(_post.id.toString()));

    return () {};
  }, []);

  return Scaffold(
    appBar: AppBar(
      title: Text(
        (BlocProvider.of<AuthCubit>(context).state as LoggedIn)
            .loggedInUser
            .name,
      ),
    ),
    body: Column(
      children: <Widget>[
        Text(_post.title),
        Divider(),
        Text(_post.body),
        Divider(),
        BlocBuilder<CommentBloc, CommentState>(
          builder: (_, commentState) {
            return commentState is FetchedComments
                ? Expanded(child: Comments(commentState.comments))
                : CircularProgressIndicator();
          },
        ),
      ],
    ),
  );
}

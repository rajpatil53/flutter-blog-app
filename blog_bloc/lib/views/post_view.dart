import 'package:blog_bloc/blocs/auth/cubit/auth_cubit.dart';
import 'package:blog_bloc/blocs/comments/bloc/comment_bloc.dart';
import 'package:blog_bloc/models/post.dart';
import 'package:blog_bloc/widgets/comments.dart';
import 'package:blog_bloc/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'post_view.g.dart';

@hwidget
Widget postView(BuildContext context, Post _post) {
  final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
  useEffect(() {
    BlocProvider.of<CommentBloc>(context)
        .add(FetchCommentsForPost(_post.id.toString()));

    return () {};
  }, []);

  return Scaffold(
    appBar: AppBar(
      title: Text(authCubit.state.loggedInUser.name),
    ),
    body: Padding(
      padding: EdgeInsets.all(15),
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
              BlocBuilder<AuthCubit, AuthState>(
                builder: (_, authState) {
                  return LikeButton(
                    isLiked: authCubit.isPostLiked(_post.id),
                    onClickHandler: () => authCubit.togglePostLike(_post.id),
                  );
                },
              ),
            ],
          ),
          Divider(),
          Text(
            _post.body,
            style: Theme.of(context).textTheme.bodyText1,
          ),
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
    ),
  );
}

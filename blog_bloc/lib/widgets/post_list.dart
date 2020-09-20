import 'package:blog_bloc/app/constants.dart';
import 'package:blog_bloc/blocs/auth/cubit/auth_cubit.dart';
import 'package:blog_bloc/models/post.dart';
import 'package:blog_bloc/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'post_list.g.dart';

@hwidget
Widget postList(BuildContext context, List<Post> posts) {
  final authCubit = BlocProvider.of<AuthCubit>(context);
  return posts.length > 0
      ? ListView.builder(
          itemCount: posts.length,
          itemBuilder: (_, index) =>
              buildSinglePost(posts[index], context, authCubit),
        )
      : Center(
          child: Text('Oops! No posts here :('),
        );
}

Widget buildSinglePost(Post post, BuildContext context, AuthCubit authCubit) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed(RoutePaths.Post, arguments: post);
    },
    child: ListTile(
      title: Text(post.title),
      trailing: LikeButton(
        isLiked: (authCubit.state as LoggedIn)
            .loggedInUser
            .likedPosts
            .contains(post.id),
        onClickHandler: () => authCubit.togglePostLike(post.id),
      ),
    ),
  );
}

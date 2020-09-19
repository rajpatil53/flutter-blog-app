import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/models/post.dart';
import 'package:blog_provider/services/api/user.dart';
import 'package:blog_provider/views/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

part 'post_list.g.dart';

@hwidget
Widget postList(BuildContext context, List<Post> posts) {
  return posts.length > 0
      ? ListView.builder(
          itemCount: posts.length,
          itemBuilder: (_, index) => buildSinglePost(posts[index], context),
        )
      : Center(
          child: Text('Oops! No posts here :('),
        );
}

Widget buildSinglePost(Post post, BuildContext context) {
  UserService userService = Provider.of<UserService>(context);
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed(RoutePaths.Post, arguments: post);
    },
    child: ListTile(
      title: Text(post.title),
      trailing: LikeButton(
        isLiked: userService.loggedInUser.likedPosts.contains(post.id),
        onClickHandler: () => userService.togglePostLike(post.id),
      ),
    ),
  );
}

import 'package:blog_redux/app/constants.dart';
import 'package:blog_redux/models/post.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'post_list.g.dart';

@hwidget
Widget postList(BuildContext context, List<Post> posts) {
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (_, index) => buildSinglePost(posts[index], context),
  );
}

Widget buildSinglePost(Post post, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed(RoutePaths.Post, arguments: post);
    },
    child: ListTile(
      title: Text(post.title),
    ),
  );
}

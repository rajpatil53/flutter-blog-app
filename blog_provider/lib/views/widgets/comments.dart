import 'package:blog_provider/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'comments.g.dart';

@hwidget
Widget comments(BuildContext context, List<Comment> _comments) {
  return ListView.builder(
    itemCount: _comments.length,
    itemBuilder: (_, index) => buildSingleComment(_comments[index]),
  );
}

Widget buildSingleComment(Comment comment) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(comment.name),
        Text(comment.email),
        Text(comment.body),
      ],
    ),
  );
}

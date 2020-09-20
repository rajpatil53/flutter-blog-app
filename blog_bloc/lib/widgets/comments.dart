import 'package:blog_bloc/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'comments.g.dart';

@hwidget
Widget comments(BuildContext context, List<Comment> _comments) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Comments',
        style: Theme.of(context).textTheme.headline1,
        textAlign: TextAlign.left,
      ),
      SizedBox(
        height: 10,
      ),
      Expanded(
        child: ListView.builder(
          itemCount: _comments.length,
          itemBuilder: (_, index) =>
              buildSingleComment(_comments[index], context),
        ),
      ),
    ],
  );
}

Widget buildSingleComment(Comment comment, BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comment.name,
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            comment.email,
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            comment.body,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'like_button.g.dart';

@hwidget
Widget likeButton(BuildContext context,
    {@required bool isLiked, @required Function onClickHandler}) {
  return IconButton(
    icon: isLiked
        ? Icon(
            Icons.favorite,
            color: Colors.redAccent,
          )
        : Icon(
            Icons.favorite_border,
            color: Colors.redAccent,
          ),
    onPressed: onClickHandler,
  );
}

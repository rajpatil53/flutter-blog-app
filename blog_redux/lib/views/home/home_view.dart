import 'package:blog_redux/models/user.dart';
import 'package:blog_redux/views/home/home_view_model.dart';
import 'package:blog_redux/widgets/post_list.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'home_view.g.dart';

@hwidget
Widget homeView(BuildContext context, HomeViewModel model) {
  // final AuthCubit auth = BlocProvider.of<AuthCubit>(context);
  final User _user = model.loggedInUser;

  useEffect(() {
    // BlocProvider.of<PostBloc>(context).add(FetchPosts());
    return () {};
  }, []);

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Hi ${_user.name.split(' ')[0]}',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.power_settings_new),
          onPressed: () => model.logout(),
        )
      ],
    ),
    body: model.loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : PostList(model.posts),
  );
}

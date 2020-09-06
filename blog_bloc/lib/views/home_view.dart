import 'package:blog_bloc/models/user.dart';
import 'package:blog_bloc/services/auth/cubit/auth_cubit.dart';
import 'package:blog_bloc/services/post/bloc/post_bloc.dart';
import 'package:blog_bloc/widgets/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'home_view.g.dart';

@hwidget
Widget homeView(BuildContext context) {
  final AuthCubit auth = BlocProvider.of<AuthCubit>(context);
  final User _user =
      auth.state is LoggedIn ? (auth.state as LoggedIn).loggedInUser : null;

  useEffect(() {
    BlocProvider.of<PostBloc>(context).add(FetchPosts());
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
          onPressed: () => auth.logoutUser(),
        )
      ],
    ),
    body: BlocBuilder<PostBloc, PostState>(
      builder: (_, postState) {
        return postState is PostsFetched
            ? PostList(postState.posts)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    ),
  );
}

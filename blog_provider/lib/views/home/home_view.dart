import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/models/user.dart';
import 'package:blog_provider/services/api/user.dart';
import 'package:blog_provider/services/api/post_service.dart';
import 'package:blog_provider/views/base_view.dart';
import 'package:blog_provider/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

part 'home_view.g.dart';

@hwidget
Widget homeView(BuildContext context) {
  final User _user = Provider.of<UserService>(context).loggedInUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  return BaseView(
    model: HomeViewModel(
      auth: Provider.of<UserService>(context),
      postService: Provider.of<PostService>(context),
    ),
    onModelReady: (HomeViewModel model) {
      model.getPosts(_scaffoldKey);
    },
    builder: (_, HomeViewModel model, __) => Scaffold(
      key: _scaffoldKey,
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
      body: model.state == ViewState.Busy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : model.displayPosts(model.currentTabIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('All Posts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind),
            title: Text('My Posts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Liked Posts'),
          ),
        ],
        currentIndex: model.currentTabIndex,
        onTap: model.updateTabIndex,
      ),
    ),
  );
}

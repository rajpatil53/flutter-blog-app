import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/models/post.dart';
import 'package:blog_provider/services/api/user.dart';
import 'package:blog_provider/services/api/post_service.dart';
import 'package:blog_provider/views/base_view_model.dart';
import 'package:blog_provider/views/widgets/post_list.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends BaseViewModel {
  final UserService auth;
  final PostService postService;
  List<Post> _posts = [];
  int _currentTabIndex = 0;

  List<Post> get posts => _posts;

  int get currentTabIndex => _currentTabIndex;

  HomeViewModel({this.auth, this.postService});

  void logout() {
    auth.logoutUser();
  }

  void getPosts(GlobalKey<ScaffoldState> scaffold) async {
    try {
      changeViewState(ViewState.Busy);
      _posts = await postService.getAllPosts();
      notifyListeners();
      changeViewState(ViewState.Idle);
    } catch (err) {
      _posts = [];
      changeViewState(ViewState.Idle);
      notifyListeners();
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text('Failed to load posts.'),
      ));
    }
  }

  void updateTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  Widget displayPosts(int currentTabIndex) {
    switch (currentTabIndex) {
      case 0:
        return PostList(_posts);
      case 1:
        return PostList(_posts
            .where((post) => post.userId == auth.loggedInUser.id)
            .toList());
      case 2:
        return PostList(_posts
            .where((post) => auth.loggedInUser.likedPosts.contains(post.id))
            .toList());
      default:
        return PostList([]);
    }
  }
}

import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/models/comment.dart';
import 'package:blog_provider/models/post.dart';
import 'package:blog_provider/services/api/post_service.dart';
import 'package:blog_provider/services/api/user.dart';
import 'package:blog_provider/views/base_view_model.dart';
import 'package:flutter/material.dart';

class PostViewModel extends BaseViewModel {
  final PostService postService;
  final UserService userService;
  final Post post;
  List<Comment> _comments = [];

  PostViewModel({this.postService, this.userService, this.post});

  List<Comment> get comments => _comments;
  bool get isLiked => userService.loggedInUser.likedPosts.contains(post.id);

  Future<void> fetchComments(
      int postId, GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      changeViewState(ViewState.Busy);
      _comments = await postService.getCommentsForPost(postId.toString());
      changeViewState(ViewState.Idle);
      notifyListeners();
    } catch (err) {
      _comments = [];
      changeViewState(ViewState.Idle);
      notifyListeners();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Failed to fetch comments.'),
        ),
      );
    }
  }

  void likeButtonHandler() {
    userService.togglePostLike(post.id);
    notifyListeners();
  }
}

import 'package:blog_redux/models/comment.dart';
import 'package:blog_redux/models/post.dart';
import 'package:blog_redux/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState {
  final User loggedInUser;
  final List<Post> posts;
  final List<Post> userPosts;
  final List<Comment> comments;
  final bool loading;

  const AppState(
      {this.loggedInUser,
      this.posts,
      this.userPosts,
      this.comments,
      this.loading = false});

  AppState.initial()
      : loggedInUser = null,
        posts = [],
        userPosts = [],
        comments = [],
        loading = false;

  AppState copyWith(
      {User loggedInUser,
      List<Post> posts,
      List<Post> userPosts,
      List<Comment> comments,
      bool loading}) {
    return AppState(
      loggedInUser: loggedInUser ?? this.loggedInUser,
      posts: posts ?? this.posts,
      userPosts: userPosts ?? this.userPosts,
      comments: comments ?? this.comments,
      loading: loading ?? this.loading,
    );
  }

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}

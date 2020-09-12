import 'package:blog_redux/models/comment.dart';
import 'package:blog_redux/models/post.dart';
import 'package:blog_redux/models/user.dart';

class LoginUser {
  final String username;
  final String password;

  LoginUser(this.username, this.password);
}

class LoginSuccess {
  User user;
  LoginSuccess(this.user);
}

class LogoutUser {}

class FetchAllPosts {}

class FetchAllPostsSuccess {
  final List<Post> posts;
  FetchAllPostsSuccess(this.posts);
}

class FetchCommentsForPost {
  final String postId;
  FetchCommentsForPost(this.postId);
}

class FetchCommentsForPostSuccess {
  final List<Comment> comments;
  FetchCommentsForPostSuccess(this.comments);
}

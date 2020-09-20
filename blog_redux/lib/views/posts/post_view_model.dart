import 'package:blog_redux/models/comment.dart';
import 'package:blog_redux/models/user.dart';
import 'package:redux/redux.dart';
import 'package:blog_redux/models/app_state.dart';

class PostViewModel {
  final User loggedInUser;
  final List<Comment> comments;
  final bool loading;

  PostViewModel({this.loggedInUser, this.comments, this.loading});

  factory PostViewModel.create(Store<AppState> store) {
    return PostViewModel(
      loggedInUser: store.state.loggedInUser,
      comments: store.state.comments,
      loading: store.state.loading,
    );
  }
}

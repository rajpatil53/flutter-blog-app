import 'package:blog_redux/models/post.dart';
import 'package:blog_redux/models/user.dart';
import 'package:redux/redux.dart';
import 'package:blog_redux/models/app_state.dart';
import 'package:blog_redux/store/actions/actions.dart';

class HomeViewModel {
  final User loggedInUser;
  final bool loading;
  final List<Post> posts;
  final Function logout;

  HomeViewModel({
    this.posts,
    this.loggedInUser,
    this.loading,
    this.logout,
  });

  factory HomeViewModel.create(Store<AppState> store) {
    void _logout() {
      store.dispatch(LogoutUser());
    }

    return HomeViewModel(
      posts: store.state.posts,
      loggedInUser: store.state.loggedInUser,
      loading: store.state.loading,
      logout: _logout,
    );
  }
}

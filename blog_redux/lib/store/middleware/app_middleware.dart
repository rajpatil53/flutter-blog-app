import 'package:blog_redux/models/user.dart';
import 'package:blog_redux/services/api/auth.dart';
import 'package:blog_redux/services/api/post_service.dart';
import 'package:blog_redux/store/actions/actions.dart';
import 'package:redux/redux.dart';
import 'package:blog_redux/models/app_state.dart';

List<Middleware<AppState>> appStateMiddelware(
    [AppState state = const AppState()]) {
  return [
    TypedMiddleware<AppState, LoginUser>(loginUser),
    TypedMiddleware<AppState, FetchAllPosts>(fetchAllPosts),
    TypedMiddleware<AppState, FetchCommentsForPost>(fetchCommentsForPost),
  ];
}

void loginUser(
    Store<AppState> store, LoginUser action, NextDispatcher next) async {
  next(action);
  User user = await AuthService.loginUser(action.username, action.password);
  store.dispatch(LoginSuccess(user));
}

void fetchAllPosts(
    Store<AppState> store, FetchAllPosts action, NextDispatcher next) async {
  next(action);
  store.dispatch(FetchAllPostsSuccess(await PostServiceImpl.getAllPosts()));
}

void fetchCommentsForPost(Store<AppState> store, FetchCommentsForPost action,
    NextDispatcher next) async {
  next(action);
  store.dispatch(FetchCommentsForPostSuccess(
      await PostServiceImpl.getCommentsForPost(action.postId)));
}

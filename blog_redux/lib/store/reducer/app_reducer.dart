import 'package:redux/redux.dart';
import 'package:blog_redux/models/app_state.dart';
import 'package:blog_redux/models/user.dart';
import 'package:blog_redux/store/actions/actions.dart';

AppState appStateReducer(AppState state, action) {
  return appReducer(state, action);
}

Reducer<AppState> appReducer = combineReducers<AppState>([
  TypedReducer<AppState, LoginUser>(loginUser),
  TypedReducer<AppState, LoginSuccess>(loggedIn),
  TypedReducer<AppState, LogoutUser>(logoutUser),
  TypedReducer<AppState, FetchAllPosts>(fetchAllPosts),
  TypedReducer<AppState, FetchAllPostsSuccess>(fetchedAllPosts),
  TypedReducer<AppState, FetchCommentsForPost>(fetchCommentsForPost),
  TypedReducer<AppState, FetchCommentsForPostSuccess>(fetchedCommentsForPost),
]);

AppState loginUser(AppState state, LoginUser action) {
  return state.copyWith(loading: true);
}

AppState loggedIn(AppState state, LoginSuccess action) {
  return state.copyWith(loggedInUser: action.user);
}

AppState logoutUser(AppState state, LogoutUser action) {
  return state.copyWith(loggedInUser: User.initial());
}

AppState fetchAllPosts(AppState state, FetchAllPosts action) {
  return state.copyWith(loading: true);
}

AppState fetchedAllPosts(AppState state, FetchAllPostsSuccess action) {
  return state.copyWith(posts: action.posts, loading: false);
}

AppState fetchCommentsForPost(AppState state, FetchCommentsForPost action) {
  return state.copyWith(loading: true);
}

AppState fetchedCommentsForPost(
    AppState state, FetchCommentsForPostSuccess action) {
  return state.copyWith(comments: action.comments, loading: false);
}

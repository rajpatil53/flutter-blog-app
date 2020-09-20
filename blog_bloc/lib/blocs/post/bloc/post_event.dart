part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class FetchPosts extends PostEvent {}

class FetchPostsForUser extends PostEvent {}

class FilterPosts extends PostEvent {
  final int tabIndex;
  final User user;
  FilterPosts(this.tabIndex, this.user);
}

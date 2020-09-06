part of 'post_bloc.dart';

@immutable
abstract class PostState {}

// class PostInitial extends PostState {}

class FetchingPosts extends PostState {}

class PostsFetched extends PostState {
  List<Post> _posts;

  List<Post> get posts => _posts;

  PostsFetched(this._posts);
}

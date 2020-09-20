part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class FetchCommentsForPost extends CommentEvent {
  final String _postId;
  FetchCommentsForPost(this._postId);
}

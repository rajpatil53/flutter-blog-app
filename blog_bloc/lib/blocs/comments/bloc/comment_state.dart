part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class FetchingComments extends CommentState {}

class FetchedComments extends CommentState {
  final List<Comment> _comments;

  List<Comment> get comments => _comments;

  FetchedComments(this._comments);
}

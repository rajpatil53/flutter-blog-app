import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:blog_bloc/app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:blog_bloc/models/comment.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(FetchingComments());

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is FetchCommentsForPost) {
      yield FetchingComments();
      List<Comment> comments = await getCommentsForPost(event._postId);
      yield FetchedComments(comments);
    }
  }

  Future<List<Comment>> getCommentsForPost(String postId) async {
    final res = await http.get('$apiUrl/comments?postId=$postId');
    final jsonList = json.decode(res.body) as List<dynamic>;
    return jsonList.map((obj) => Comment.fromJson(obj)).toList();
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:blog_bloc/app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:blog_bloc/models/comment.dart';
import 'package:blog_bloc/models/post.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(FetchingPosts());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is FetchPosts) {
      yield FetchingPosts();
      yield PostsFetched(await getAllPosts());
    } else if (event is FetchPostsForUser) {
      yield FetchingPosts();
      yield PostsFetched(await getAllPostsForUser('1'));
    }
  }

  Future<List<Post>> getAllPostsForUser(String userId) async {
    final res = await http.get('$apiUrl/posts?userId=$userId');
    final jsonList = json.decode(res.body) as List<dynamic>;
    return jsonList.map((obj) => Post.fromJson(obj)).toList();
  }

  Future<List<Post>> getAllPosts() async {
    final res = await http.get('$apiUrl/posts');
    final jsonList = json.decode(res.body) as List<dynamic>;
    return jsonList.map((obj) => Post.fromJson(obj)).toList();
  }
}

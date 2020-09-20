import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:blog_bloc/app/constants.dart';
import 'package:blog_bloc/models/user.dart';
import 'package:http/http.dart' as http;
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
      yield PostsFetched(posts: await getAllPosts(), currentTabIndex: 0);
    } else if (event is FilterPosts) {
      // yield FetchingPosts();
      final currentState = state as PostsFetched;
      if (event.tabIndex == 0) {
        yield PostsFetched(posts: currentState.posts, currentTabIndex: 0);
      } else if (event.tabIndex == 1) {
        yield PostsFetched(
            posts: currentState.posts, currentTabIndex: 1, user: event.user);
      } else if (event.tabIndex == 2) {
        yield PostsFetched(
            posts: currentState.posts, currentTabIndex: 2, user: event.user);
      }
    }
  }

  List<Post> getAllPostsForUser(List<Post> allPosts, int userId) {
    return allPosts.where((post) => post.id == userId).toList();
  }

  List<Post> getLikedPosts(List<Post> allPosts, List<int> likedPosts) {
    return allPosts.where((post) => likedPosts.contains(post.id)).toList();
  }

  Future<List<Post>> getAllPosts() async {
    final res = await http.get('$apiUrl/posts');
    final jsonList = json.decode(res.body) as List<dynamic>;
    return jsonList.map((obj) => Post.fromJson(obj)).toList();
  }
}

import 'dart:convert';

import 'package:blog_mobx/app/constants.dart';
import 'package:blog_mobx/models/comment.dart';
import 'package:blog_mobx/models/post.dart';
import 'package:http/http.dart' as http;

abstract class PostService {
  Future<List<Post>> getAllPosts();
  Future<List<Post>> getAllPostsForUser(String userId);
  Future<List<Comment>> getCommentsForPost(String postId);
}

class PostServiceImpl implements PostService {
  @override
  Future<List<Post>> getAllPostsForUser(String userId) async {
    final res = await http.get('$apiUrl/posts?userId=$userId');
    final jsonList = json.decode(res.body) as List<dynamic>;
    return jsonList.map((obj) => Post.fromJson(obj)).toList();
  }

  @override
  Future<List<Post>> getAllPosts() async {
    final res = await http.get('$apiUrl/posts');
    final jsonList = json.decode(res.body) as List<dynamic>;
    return jsonList.map((obj) => Post.fromJson(obj)).toList();
  }

  @override
  Future<List<Comment>> getCommentsForPost(String postId) async {
    final res = await http.get('$apiUrl/comments?postId=$postId');
    final jsonList = json.decode(res.body) as List<dynamic>;
    return jsonList.map((obj) => Comment.fromJson(obj)).toList();
  }
}

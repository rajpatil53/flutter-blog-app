import 'package:blog_mobx/app/constants.dart';
import 'package:blog_mobx/models/comment.dart';
import 'package:blog_mobx/models/post.dart';
import 'package:mobx/mobx.dart';

import 'package:blog_mobx/services/api/post_service.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  final PostServiceImpl postService;

  _PostStore(this.postService);

  @observable
  ObservableFuture _future;

  @observable
  ObservableFuture _commentsFuture;

  @observable
  List<Post> posts;

  @observable
  List<Comment> comments;

  @computed
  ViewState get viewState {
    if (_future == null) return ViewState.Idle;
    return _future.status == FutureStatus.pending
        ? ViewState.Busy
        : ViewState.Idle;
  }

  @computed
  ViewState get commentsViewState {
    if (_commentsFuture == null) return ViewState.Idle;
    return _commentsFuture.status == FutureStatus.pending
        ? ViewState.Busy
        : ViewState.Idle;
  }

  @action
  Future<void> getAllPosts() async {
    _future = ObservableFuture(postService.getAllPosts());
    posts = await _future;
  }

  @action
  Future<void> getCommentsForPost(String postId) async {
    _commentsFuture = ObservableFuture(postService.getCommentsForPost(postId));
    comments = await _commentsFuture;
  }
}

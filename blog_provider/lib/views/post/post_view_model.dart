import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/models/comment.dart';
import 'package:blog_provider/services/api/post_service.dart';
import 'package:blog_provider/views/base_view_model.dart';

class PostViewModel extends BaseViewModel {
  final PostService postService;
  List<Comment> _comments = [];

  PostViewModel({this.postService});

  List<Comment> get comments => _comments;

  Future<void> fetchComments(int postId) async {
    changeViewState(ViewState.Busy);
    _comments = await postService.getCommentsForPost(postId.toString());
    changeViewState(ViewState.Idle);
    notifyListeners();
  }
}

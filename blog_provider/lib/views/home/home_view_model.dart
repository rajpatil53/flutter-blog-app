import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/models/post.dart';
import 'package:blog_provider/services/api/auth.dart';
import 'package:blog_provider/services/api/post_service.dart';
import 'package:blog_provider/views/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final AuthService auth;
  final PostService postService;
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  HomeViewModel({this.auth, this.postService});

  void logout() {
    auth.logoutUser();
  }

  void getPosts(String id) async {
    changeViewState(ViewState.Busy);
    _posts = await postService.getAllPosts();
    notifyListeners();
    changeViewState(ViewState.Idle);
  }
}

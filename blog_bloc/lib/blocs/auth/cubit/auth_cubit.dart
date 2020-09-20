import 'package:bloc/bloc.dart';
import 'package:blog_bloc/models/user.dart';
import 'package:blog_bloc/repos/user_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(NotLoggedIn());

  UserRepo userRepo = UserRepo();

  Future<void> login(String id, String password) async {
    emit(LoggingIn());
    if (int.parse(id) > 0 && int.parse(id) < 11) {
      try {
        User user = await userRepo.getUser(id);
        if (await userRepo.isUserPresent(id)) {
          user.likedPosts = await userRepo.getLikedPosts(id);
        } else {
          user.likedPosts = [];
        }
        emit(LoggedIn(user));
      } catch (err) {
        emit(LoginException("Login failed."));
      }
    } else {
      emit(
          LoginException("Incorrect username (Enter a number between 1 & 10)"));
    }
  }

  Future<void> logoutUser() async {
    emit(NotLoggedIn());
  }

  Future<void> togglePostLike(int postId) async {
    if (state.loggedInUser.likedPosts.contains(postId)) {
      state.loggedInUser.likedPosts.remove(postId);
    } else {
      state.loggedInUser.likedPosts.add(postId);
    }
    emit(LoggedIn(state.loggedInUser));
    await userRepo.storeLikedPosts(
        state.loggedInUser.id.toString(), state.loggedInUser.likedPosts);
  }

  bool isPostLiked(int id) {
    return state.loggedInUser.likedPosts.contains(id);
  }
}

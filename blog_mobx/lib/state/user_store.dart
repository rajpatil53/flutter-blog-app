import 'package:blog_mobx/app/constants.dart';
import 'package:blog_mobx/models/user.dart';
import 'package:mobx/mobx.dart';

import 'package:blog_mobx/services/api/auth.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  final AuthService authService;

  _UserStore(this.authService);

  @observable
  ObservableFuture _future;

  @observable
  User loggedInUser;

  @computed
  ViewState get viewState {
    if (_future == null) return ViewState.Idle;
    return _future.status == FutureStatus.pending
        ? ViewState.Busy
        : ViewState.Idle;
  }

  @action
  Future<void> loginUser(String username, String password) async {
    _future = ObservableFuture(authService.loginUser(username, password));
    loggedInUser = await _future;
  }

  @action
  void logoutUser() {
    loggedInUser = null;
  }
}

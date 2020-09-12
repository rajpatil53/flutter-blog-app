import 'package:blog_redux/models/user.dart';
import 'package:redux/redux.dart';
import 'package:blog_redux/models/app_state.dart';
import 'package:blog_redux/store/actions/actions.dart';

class LoginViewModel {
  final Function(String, String) login;
  final User loggedInUser;
  final bool loading;

  LoginViewModel({this.login, this.loggedInUser, this.loading});

  factory LoginViewModel.create(Store<AppState> store) {
    void _loginUser(String username, String password) {
      store.dispatch(LoginUser(username, password));
    }

    return LoginViewModel(
      login: _loginUser,
      loggedInUser: store.state.loggedInUser,
      loading: store.state.loading,
    );
  }
}

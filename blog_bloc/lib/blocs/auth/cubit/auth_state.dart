part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  User get loggedInUser => null;
}

class NotLoggedIn extends AuthState {}

class LoggingIn extends AuthState {}

class LoggedIn extends AuthState {
  final User _user;

  User get loggedInUser => _user;

  LoggedIn(this._user);
}

class LoginException extends AuthState {
  final String message;

  LoginException(this.message);
}

part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class NotLoggedIn extends AuthState {}

class LoggingIn extends AuthState {}

class LoggedIn extends AuthState {
  final User _user;

  User get loggedInUser => _user;

  LoggedIn(this._user);
}

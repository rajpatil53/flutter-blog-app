import 'package:flutter/material.dart';
import '../app/constants.dart';

class BaseViewModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state {
    return _state;
  }

  void changeViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}

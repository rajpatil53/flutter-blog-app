import 'dart:convert';

import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/models/user.dart';
import 'package:blog_provider/services/device_storage/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class UserService with ChangeNotifier {
  User get loggedInUser;
  Future<void> loginUser(String id, String password);
  Future<void> logoutUser();
  Future<User> getUser(String id);
  void togglePostLike(int postId);
}

class UserServiceImpl with ChangeNotifier implements UserService {
  SharedPrefService sharedPrefService;
  UserServiceImpl({@required this.sharedPrefService});
  User _user;

  User get loggedInUser => _user;

  Future<void> loginUser(String id, String password) async {
    if (int.parse(id) > 0 && int.parse(id) < 11) {
      User user = await getUser(id);
      if (await sharedPrefService.isKeyPresent(id)) {
        user.likedPosts =
            List<int>.from(json.decode(await sharedPrefService.getItem(id)));
      } else {
        user.likedPosts = [];
      }
      _user = user;
    } else {
      throw Exception("Incorrect username (Enter a number between 1 & 10)");
    }
    notifyListeners();
  }

  Future<void> logoutUser() async {
    _user = null;
    notifyListeners();
  }

  Future<User> getUser(String id) async {
    final res = await http.get('$apiUrl/users/$id');
    User user = User.fromJson(json.decode(res.body) as Map<String, dynamic>);
    return user;
  }

  @override
  void togglePostLike(int postId) async {
    if (_user.likedPosts.contains(postId)) {
      _user.likedPosts.remove(postId);
    } else {
      _user.likedPosts.add(postId);
    }
    notifyListeners();
    await sharedPrefService.storeItem(_user.id.toString(), _user.likedPosts);
  }
}

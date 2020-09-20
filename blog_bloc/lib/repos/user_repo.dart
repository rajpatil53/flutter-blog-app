import 'dart:convert';

import 'package:blog_bloc/models/user.dart';
import 'package:blog_bloc/services/api/user_api.dart';
import 'package:blog_bloc/services/shared_prefs/shared_prefs.dart';

class UserRepo {
  UserService userService = UserServiceImpl();
  SharedPrefService sharedPref = SharedPrefServiceImpl();

  Future<User> getUser(String id) async => await userService.getUser(id);

  Future<bool> isUserPresent(String id) async =>
      await sharedPref.isKeyPresent(id);

  Future<List<int>> getLikedPosts(String id) async {
    return List<int>.from(json.decode(await sharedPref.getItem(id)));
  }

  Future storeLikedPosts(String id, List<int> likedPosts) async =>
      await sharedPref.storeItem(id, likedPosts);
}

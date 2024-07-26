import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plagia_oc/utils/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, UserModel?>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null) {
    loadUser();
  }

  Future<UserModel?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      state = UserModel.fromJson(userData);
    }
    return state;
  }

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user.toJson());
    state = user;
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    state = null;
  }
}

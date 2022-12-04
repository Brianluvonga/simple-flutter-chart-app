import 'dart:collection';

import 'package:chartapp/components/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModelNotifier extends ChangeNotifier {
  UserModel? _currentUser = UserModel();
  List<UserModel> _userList = [];

  UserModel get currentUser => _currentUser!;

  UnmodifiableListView<UserModel> get userList =>
      UnmodifiableListView(_userList);

  void setCurrentUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  set userList(List<UserModel> userList) {
    _userList = userList;
    notifyListeners();
  }

  set currentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }
}

class AuthNotifier with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  set currentUserLoggedIn(UserModel? user) {
    _user = user as User?;
    notifyListeners();
  }
}

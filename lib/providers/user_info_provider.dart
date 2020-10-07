import 'package:flutter/cupertino.dart';

class UserInfoProvider extends ChangeNotifier {
  String _username;

  void addUsername(String username) {
    _username = username;
    notifyListeners();
  }

  String get username => _username;
}

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class UserInfoProvider extends ChangeNotifier {
  String _username;
  String _password;
  Position _position;
  Position _tempPosition;

  void addUsernameAndPassword(String username, String password) {
    _username = username;
    _password = password;
    notifyListeners();
  }

  void getLatLngUser() async {
    _tempPosition =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    notifyListeners();
  }

  void cleanTempPosition() {
    _tempPosition = null;
  }

  bool checkPassword(String password) {
    if (password == _password) {
      saveLatLngUser(_tempPosition);
      return true;
    }
    return false;
  }

  void saveLatLngUser(Position position) {
    _position = position;
    notifyListeners();
  }

  String get username => _username;
  String get password => _password;
  Position get position => _position;
  Position get tempPosition => _tempPosition;
}

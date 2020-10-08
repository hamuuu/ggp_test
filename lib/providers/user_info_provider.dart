import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserInfoProvider extends ChangeNotifier {
  String _username;
  String _password;
  Position _position;
  Position _tempPosition;
  int _checkInStatus = -1;
  bool _checkoutButton = false;
  bool _checkinButton = true;
  bool _isLoadingChangeLatLng = false;

  double _checkInLongitude = 106.8072643;
  double _checkInLatitude = -6.2254236;

  void addUsernameAndPassword(String username, String password) {
    _username = username;
    _password = password;
    notifyListeners();
  }

  void _checkUserPermission() async {
    await checkPermission().then((value) async {
      if (value == LocationPermission.denied) return await requestPermission();
      return checkPermission();
    });
  }

  void getLatLngUser() async {
    _checkUserPermission();
    _isLoadingChangeLatLng = true;
    notifyListeners();
    _tempPosition =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    notifyListeners();
    _isLoadingChangeLatLng = false;
    notifyListeners();
  }

  void checkIn() {
    //status 0 = sudah check in
    //status 1 = belum set posisi
    //status 2 = diluar jangkauan
    //status 3 = sukses
    checkUserAlreadyCheckIn().then((value) {
      if (value) {
        if (_position != null) {
          if (isLocationBelowOneKm(_position)) {
            _checkInStatus = 3;
            _checkinButton = false;
            _checkoutButton = true;
            notifyListeners();

            storeCheckInRecordToFirestore();
          } else {
            _checkInStatus = 2;
            notifyListeners();
          }
        } else {
          _checkInStatus = 1;
          notifyListeners();
        }
      } else
        _checkInStatus = 0;
      notifyListeners();
    });
  }

  bool isLocationBelowOneKm(Position position) {
    double distance = distanceBetween(position.latitude, position.longitude,
        _checkInLatitude, _checkInLongitude);
    return (distance <= 1000.0);
  }

  Future<bool> checkUserAlreadyCheckIn() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: _username)
        .where("flag_check_in", isEqualTo: false)
        .limit(1)
        .get();
    return result.docs.length > 0;
  }

  void storeCheckInRecordToFirestore() async {
    await FirebaseFirestore.instance.collection("check_in").add({
      "username": _username,
      "lat": position.latitude,
      "lng": position.longitude,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    });
    await FirebaseFirestore.instance.doc('users/' + _username).update({
      "flag_check_in": true,
    });
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

  void clearProvider() {
    _username = null;
    _password = null;
    _position = null;
    _tempPosition = null;
    _checkInStatus = -1;
    _checkoutButton = false;
    _checkinButton = true;
  }

  void clearCheckInStatus() {
    _checkInStatus = -1;
    _checkinButton = true;
    _checkoutButton = false;
    notifyListeners();
  }

  String get username => _username;
  String get password => _password;
  int get checkInStatus => _checkInStatus;
  Position get position => _position;
  Position get tempPosition => _tempPosition;
  bool get checkoutButton => _checkoutButton;
  bool get checkinButton => _checkinButton;
  bool get isLoadingChangeLatLng => _isLoadingChangeLatLng;
}

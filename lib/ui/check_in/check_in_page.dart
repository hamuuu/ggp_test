import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ggp_test/providers/user_info_provider.dart';
import 'package:ggp_test/ui/check_in/check_in_bottom_section.dart';
import 'package:ggp_test/ui/check_in/check_in_top_section.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  bool _checkoutButton = false;
  bool _checkinButton = true;
  bool _checkedOut = false;
  int _second = 0;
  int _hour = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            CheckInAccountTopSection(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 120),
              child: RaisedButton(
                color: _checkinButton ? Colors.blue : Colors.lightBlue[100],
                onPressed: () => _checkinButton ? _checkIn() : null,
                child: Text(
                  'Check In',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: RaisedButton(
                color: _checkoutButton
                    ? Colors.red
                    : Color.fromRGBO(224, 113, 105, 100),
                onPressed: () => _checkoutButton ? _checkOut() : null,
                child: Text(
                  'Check Out',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Check In Process',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Check In Failed',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Anda berada diluar jangkauan',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _hour.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  ' : ',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  _second.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            CheckInPageBottomSection(),
          ],
        ),
      ),
    );
  }

  void _checkOut() {
    _checkedOut = true;
    setState(() {
      _checkinButton = !_checkinButton;
      _checkoutButton = !_checkoutButton;
    });
  }

  void _checkUserPermission() async {
    await checkPermission().then((value) async {
      if (value == LocationPermission.denied) return await requestPermission();
      return checkPermission();
    });
  }

  void _checkIn() {
    _checkUserPermission();
    setState(() {
      _checkinButton = !_checkinButton;
      _checkoutButton = !_checkoutButton;
    });

    Provider.of<UserInfoProvider>(context, listen: false).getLatLngUser();

    Timer.periodic(Duration(seconds: 60), (timer) {
      if (!_checkedOut)
        Provider.of<UserInfoProvider>(context, listen: false).getLatLngUser();
      if (_checkedOut) {
        timer.cancel();
        _checkedOut = false;
      }
    });
  }
}

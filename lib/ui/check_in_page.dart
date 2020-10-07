import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ggp_test/providers/user_info_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black87,
                    Colors.black54,
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 48,
                backgroundImage: NetworkImage(
                    'https://www.iconfinder.com/data/icons/eldorado-user/40/user-512.png'),
              ),
            ),
            SizedBox(height: 10),
            Text(
              Provider.of<UserInfoProvider>(context).username,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 100),
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

  void _checkIn() {
    setState(() {
      _checkinButton = !_checkinButton;
      _checkoutButton = !_checkoutButton;
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_checkedOut) {
        timer.cancel();
        _checkedOut = false;
      }

      print(timer);
    });
  }
}

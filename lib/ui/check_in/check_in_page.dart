import 'package:flutter/material.dart';
import 'package:ggp_test/providers/user_info_provider.dart';
import 'package:ggp_test/ui/check_in/check_in_bottom_section.dart';
import 'package:ggp_test/ui/check_in/check_in_status.dart';
import 'package:ggp_test/ui/check_in/check_in_timer.dart';
import 'package:ggp_test/ui/check_in/check_in_top_section.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
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
              child: context.watch<UserInfoProvider>().checkinButton
                  ? RaisedButton(
                      color: Colors.blue[800],
                      onPressed: () => _checkIn(),
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
                    )
                  : FlatButton(
                      color: Colors.lightBlue[100],
                      onPressed: () => null,
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
              child: context.watch<UserInfoProvider>().checkoutButton
                  ? RaisedButton(
                      color: Colors.red,
                      onPressed: () =>
                          context.read<UserInfoProvider>().clearCheckInStatus(),
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
                    )
                  : FlatButton(
                      color: Colors.red[100],
                      onPressed: () => null,
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
            context.watch<UserInfoProvider>().checkInStatus != null
                ? CheckInStatus()
                : SizedBox.shrink(),
            SizedBox(height: 20),
            CheckInTimer(),
            SizedBox(height: 15),
            CheckInPageBottomSection(
              checkinButton: context.watch<UserInfoProvider>().checkinButton,
            ),
          ],
        ),
      ),
    );
  }

  void _checkIn() {
    context.read<UserInfoProvider>().checkIn();
    // Timer.periodic(Duration(seconds: 60), (Timer t) {
    //   if (!context.watch<UserInfoProvider>().checkoutButton)
    //     context.read<UserInfoProvider>().checkIn();
    //   if (!context.watch<UserInfoProvider>().checkoutButton){
    //     t.cancel();
    //   }
    // });
  }
}

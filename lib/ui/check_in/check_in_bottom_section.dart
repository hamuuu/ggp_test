import 'package:flutter/material.dart';
import 'package:ggp_test/ui/change_location/change_location_page.dart';
import 'package:ggp_test/ui/login/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckInPageBottomSection extends StatelessWidget {
  const CheckInPageBottomSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: RaisedButton(
            color: Colors.green[600],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeLocationPage(),
                ),
              );
            },
            child: Text(
              'Change Location',
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
          padding: EdgeInsets.symmetric(horizontal: 130),
          child: RaisedButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
            child: Text(
              'Logout',
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
    );
  }
}

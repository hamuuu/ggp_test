import 'package:flutter/material.dart';
import 'package:ggp_test/providers/user_info_provider.dart';
import 'package:ggp_test/ui/change_location/change_location_page.dart';
import 'package:ggp_test/ui/login/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckInPageBottomSection extends StatelessWidget {
  final bool checkinButton;

  const CheckInPageBottomSection({Key key, this.checkinButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: RaisedButton(
            color: checkinButton ? Colors.green[600] : Colors.green[100],
            onPressed: () => checkinButton
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeLocationPage(),
                    ),
                  )
                : null,
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
              context.read<UserInfoProvider>().clearProvider();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return LoginPage();
                },
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

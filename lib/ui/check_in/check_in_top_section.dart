import 'package:flutter/material.dart';
import 'package:ggp_test/providers/user_info_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckInAccountTopSection extends StatelessWidget {
  const CheckInAccountTopSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.12,
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
          context.watch<UserInfoProvider>().username,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ggp_test/providers/user_info_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangeLocationPage extends StatefulWidget {
  @override
  _ChangeLocationPageState createState() => _ChangeLocationPageState();
}

class _ChangeLocationPageState extends State<ChangeLocationPage> {
  String _longitude;
  String _latitude;
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (context.watch<UserInfoProvider>().position != null &&
        context.watch<UserInfoProvider>().tempPosition == null) {
      _longitude =
          context.watch<UserInfoProvider>().position.longitude.toString();
      _latitude =
          context.watch<UserInfoProvider>().position.latitude.toString();
    } else if (context.watch<UserInfoProvider>().tempPosition != null) {
      _longitude =
          context.watch<UserInfoProvider>().tempPosition.longitude.toString();
      _latitude =
          context.watch<UserInfoProvider>().tempPosition.latitude.toString();
    } else {
      _longitude = "Belum Terdeteksi";
      _latitude = "Belum Terdeteksi";
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
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
            Text(
              'Your Location',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            !context.watch<UserInfoProvider>().isLoadingChangeLatLng
                ? Column(
                    children: [
                      Text(
                        'Long : ' + _longitude,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(),
                      ),
                      Text(
                        'Lat : ' + _latitude,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.44),
                    child: CircularProgressIndicator(),
                  ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  context.read<UserInfoProvider>().getLatLngUser();
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
            SizedBox(height: 20),
            Text(
              'Masukan Password',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(
                  color: Colors.blue[600],
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            Builder(
              builder: (context) => Container(
                padding: EdgeInsets.symmetric(horizontal: 120),
                child: RaisedButton(
                  color: Colors.green[700],
                  onPressed: () {
                    if (context
                        .read<UserInfoProvider>()
                        .checkPassword(passwordController.text)) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Lokasi berhasil diubah'),
                        ),
                      );
                      passwordController.clear();
                    } else
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Lokasi gagal diubah, cek kembali password anda'),
                        ),
                      );
                  },
                  child: Text(
                    'Save',
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
            ),
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 120),
              child: RaisedButton(
                color: Colors.red,
                onPressed: () {
                  context.read<UserInfoProvider>().cleanTempPosition();
                  Navigator.pop(context);
                },
                child: Text(
                  'Back',
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
}

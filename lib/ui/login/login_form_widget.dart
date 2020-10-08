import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ggp_test/providers/user_info_provider.dart';
import 'package:ggp_test/ui/check_in/check_in_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.usernameController,
    @required this.passwordController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Authentication',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: widget.usernameController,
              style: TextStyle(
                color: Colors.blue[600],
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Username',
                hintStyle: TextStyle(color: Colors.grey[300]),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: widget.passwordController,
              obscureText: true,
              style: TextStyle(
                color: Colors.blue[600],
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey[300]),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ButtonTheme(
              buttonColor: Colors.black,
              child: RaisedButton(
                onPressed: () {
                  if (widget._formKey.currentState.validate()) {
                    print(widget.usernameController.text +
                        ' ' +
                        widget.passwordController.text);
                    _loginAuth();
                  }
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _loginAuth() async {
    await Firebase.initializeApp().whenComplete(() async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.usernameController.text)
          .get()
          .then((value) {
        if (widget.usernameController.text == value.data()['username'] &&
            widget.passwordController.text == value.data()['password']) {
          context.read<UserInfoProvider>().addUsernameAndPassword(
              value.data()['username'], value.data()['password']);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CheckInPage(),
            ),
          );
        } else {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('Username atau password salah')));
        }
      });
    });
  }
}

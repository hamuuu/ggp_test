import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ggp_test/ui/login_form_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<DocumentSnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("users")
        .doc("Be3mhKhKBOqumRjqshcQ")
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login-background.jpg'),
            fit: BoxFit.fill,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[400],
              Colors.blue[200],
              Colors.blue[400],
            ],
          ),
        ),
        child: Center(
          child: Theme(
            data: ThemeData(
              primaryColor: Colors.white,
            ),
            child: FormLogin(
                formKey: _formKey,
                usernameController: usernameController,
                passwordController: passwordController),
          ),
        ),
      ),
    );
  }
}

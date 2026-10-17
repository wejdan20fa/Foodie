import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodi/Authentication/Login/phoneNumberLogin.dart';
import 'package:foodi/Authentication/Register/phoneNumberRegister.dart';
import 'package:foodi/Authentication/Register/RegisterPage.dart';
import 'package:foodi/Authentication/Reset/RestPasswordPhoneNumber.dart';
import 'package:foodi/config/config.dart';
import 'package:foodi/home/homeScreen.dart';
import 'package:foodi/splashScreen.dart';
import '../../../DialogBox/errorDialog.dart';
import '../../../DialogBox/loadingDialog.dart';

class RestPasswordPage extends StatefulWidget {
  String UserID;

  RestPasswordPage({Key? key, required this.UserID}) : super(key: key);

  @override
  State<RestPasswordPage> createState() => _RestPasswordPageState();
}

class _RestPasswordPageState extends State<RestPasswordPage> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool obscureText = true;

  @override
  void initState() {
    callingData();
    super.initState();
  }

  callingData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.UserID)
        .get()
        .then(
      (reults) {
        setState(() {
          _password.text = reults['password'];
          _userName.text = reults['username'];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Foodi.greenColor,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(15),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Foodi.greenColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          margin: const EdgeInsets.all(5),
                          child: TextField(
                            controller: _userName,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "Enter Username",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Foodi.orangeColor,
                                ),
                              ),
                              isCollapsed: false,
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Foodi.orangeColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          margin: const EdgeInsets.all(5),
                          child: TextField(
                            obscureText: obscureText,
                            controller: _password,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Foodi.orangeColor,
                                ),
                              ),
                              isCollapsed: false,
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Foodi.orangeColor,
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: Icon(
                                  obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  ResetPassword();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Foodi.orangeColor,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 8),
                                  child: Text(
                                    "Reset Password",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ResetPassword() async {
    _userName.text.isNotEmpty && _password.text.isNotEmpty
        ? ValidatingData()
        : displayDialog();
  }

  displayDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) {
        return const ErrorAlertDialog(
          message: "Please Fill up the form",
        );
      },
    );
  }

  ValidatingData() async {
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingAlertDialog(
            message: "Reseting Password",
          );
        });
    updatingPasssowd();
  }

  void updatingPasssowd() async {
    FirebaseFirestore.instance.collection("users").doc(widget.UserID).update({
      "username": _userName.text.trim(),
      "password": _password.text.trim(),
    }).then((results) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password Changed Successfully"),
          duration: Duration(seconds: 1),
        ),
      );

      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SplashScreen()),
        );
      });
    });
  }
}

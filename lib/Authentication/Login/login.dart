import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:foodi/Authentication/Login/phoneNumberLogin.dart';
import 'package:foodi/Authentication/Register/phoneNumberRegister.dart';
import 'package:foodi/Authentication/Register/RegisterPage.dart';
import 'package:foodi/Authentication/Reset/RestPasswordPhoneNumber.dart';
import 'package:foodi/config/config.dart';
import 'package:foodi/home/homeScreen.dart';
import '../../../DialogBox/errorDialog.dart';
import '../../../DialogBox/loadingDialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool obscureText = true;

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
                                  SignInFunction();
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
                                    "Sign In",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("No Account?"),
                                TextButton(
                                  onPressed: () {
                                    Route route = MaterialPageRoute(
                                        builder: (_) => const RegisterPage());
                                    Navigator.push(context, route);
                                  },
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Forget Password?"),
                                TextButton(
                                  onPressed: () {
                                    Route route = MaterialPageRoute(
                                        builder: (_) =>
                                            RestPasswordPhoneNumber());
                                    Navigator.push(context, route);
                                  },
                                  child: const Text(
                                    "Reset",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
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

  SignInFunction() async {
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
            message: "Authenticating user...",
          );
        });
    Login();
  }

  void Login() async {
    // Fetch user data based on username
    var results = await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: _userName.text.trim())
        .get();

    if (results.docs.isNotEmpty) {
      // Get the first user's data
      var userData = results.docs.first.data();
      // Retrieve stored hashed password from Firestore
      String storedHashedPassword = userData['password'];

      // Verify the entered password against the stored hashed password
      bool isPasswordCorrect = await FlutterBcrypt.verify(
        password: _password.text.trim(),
        hash: storedHashedPassword,
      );

      if (isPasswordCorrect) {
        // Password is correct, proceed with login
        Navigator.pop(context);
        String userID = results.docs[0].id;
        String userType = results.docs[0]['type'];
        if (userID.isNotEmpty) {
          String phoneNumber = results.docs[0]["phoneNumber"];
          String name = results.docs[0]['username'];
          Foodi.sharedPreferences?.setString("username", name);

          Route route = MaterialPageRoute(
              builder: (_) => phoneNumberLogin(
                    phoneNumber: phoneNumber,
                    userType: userType,
                  ));
          Navigator.push(context, route);
        }
      } else {
        // Handle incorrect password
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text("Please make sure the username and password are correct."),
          ),
        );
      }
    } else {
      // No user found with that username
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No user found with that username."),
        ),
      );
    }
  }
}

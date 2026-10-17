import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:foodi/DialogBox/loadingDialog.dart';
import 'package:foodi/config/config.dart';
import 'package:foodi/home/homeScreen.dart';

enum Gender { male, female, other }

class adminEditProfile extends StatefulWidget {
  const adminEditProfile({Key? key}) : super(key: key);

  @override
  _adminEditProfileState createState() => _adminEditProfileState();
}

class _adminEditProfileState extends State<adminEditProfile> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool obscureText = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? currentUser = FirebaseAuth.instance.currentUser?.uid;
  String username = Foodi.sharedPreferences!.getString("username").toString();

  @override
  void initState() {
    super.initState();
    fetchCurrentUserInfo();
  }

  void fetchCurrentUserInfo() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser)
        .get();
    setState(() {
      _userName.text = userDoc.get('username');
      _emailAddress.text = userDoc.get('email');
      _phoneNumber.text = userDoc.get('phoneNumber');
      _password.text = userDoc.get('password');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'images/2.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              const SizedBox(height: 80),
              const CircleAvatar(
                backgroundColor: Colors.black,
                radius: 40,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  username,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      margin: const EdgeInsets.all(5),
                      child: TextFormField(
                        controller: _userName,
                        decoration: InputDecoration(
                          hintText: "Enter User Name",
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
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          if (value.contains(' ')) {
                            return 'Username cannot contain spaces';
                          }
                          if (value.length < 4) {
                            return 'Username must be > 4';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      margin: const EdgeInsets.all(5),
                      child: TextFormField(
                        controller: _emailAddress,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: "Enter Email Address",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Foodi.orangeColor,
                            ),
                          ),
                          isCollapsed: false,
                          isDense: true,
                          contentPadding: const EdgeInsets.all(10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Foodi.orangeColor,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }

                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      margin: const EdgeInsets.all(5),
                      child: TextFormField(
                        enabled: false,
                        controller: _phoneNumber,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: "Enter Phone Number",
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
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }

                          if (value.length < 10 || value.length > 15) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      margin: const EdgeInsets.all(5),
                      child: TextFormField(
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
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          if (value.length > 20) {
                            return 'Password must be at least within 20 characters';
                          }
                          return null;
                        },
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
                              if (_formKey.currentState!.validate()) {
                                updateProfileData();
                              }
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
                                "Update",
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
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updateProfileData() async {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          const LoadingAlertDialog(message: "Updating Profile..."),
    );

    FirebaseFirestore.instance.collection("users").doc(currentUser).update({
      'username': _userName.text.trim(),
      'email': _emailAddress.text.trim(),
      'password': _password.text.trim(),
    }).then((_) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Updated Successfully')),
      );
    }).catchError((error) {
      Navigator.pop(context);
      print("Error updating profile: $error");
    });
  }
}

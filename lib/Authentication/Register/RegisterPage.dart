import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodi/Authentication/Login/login.dart';
import 'package:foodi/Authentication/Register/phoneNumberRegister.dart';
import 'package:foodi/config/config.dart';
import 'package:foodi/home/homeScreen.dart';
import '../../../DialogBox/loadingDialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool obscureText = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              child: Column(
                children: [
                  Container(
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
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
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

                                    if (value.length < 10 ||
                                        value.length > 15) {
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
                                      return 'Password must be within 20 characters';
                                    }
                                    if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
                                      return 'Password must contain at least one letter';
                                    }
                                    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                        .hasMatch(value)) {
                                      return 'Password must contain at least one special character';
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
                                          ValidatingData();
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Foodi.orangeColor,
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 8),
                                        child: Text(
                                          "Sign Up",
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
                                  Row(
                                    children: [
                                      const Text("Already Have an Account?"),
                                      TextButton(
                                        onPressed: () {
                                          Route route = MaterialPageRoute(
                                              builder: (_) =>
                                                  const LoginPage());
                                          Navigator.push(context, route);
                                        },
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Route route = MaterialPageRoute(
                                      builder: (_) => const HomeScreen());
                                  Navigator.push(context, route);
                                },
                                child: const Text(
                                  "Not Now",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ValidatingData() async {
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingAlertDialog(
            message: "Validating User",
          );
        });
    register();
  }

  Future<bool> userExists() async {
    var results = await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: _userName.text.trim())
        .get();

    if (results.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  void register() async {
    bool userExisit = await userExists();
    if (!userExisit) {
      Map<String, dynamic> allData = ({
        'username': _userName.text.trim(),
        'email': _emailAddress.text.trim(),
        'phoneNumber': _phoneNumber.text.trim(),
        "password": _password.text.trim(),
        "date": DateTime.now(),
        "type": "user",
      });

      Navigator.pop(context);
      Route route = MaterialPageRoute(
        builder: (_) => phoneNumberRegister(
          phoneNumber: _phoneNumber.text.trim(),
          allData: allData,
        ),
      );
      Navigator.push(context, route);
      setState(() {});
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "This username already exisit, please pick another or login"),
        ),
      );
    }
  }
}

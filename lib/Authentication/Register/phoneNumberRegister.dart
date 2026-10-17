import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:foodi/Authentication/Login/login.dart';
import 'package:foodi/config/config.dart';
import 'package:foodi/home/homeScreen.dart';
import '../../../DialogBox/errorDialog.dart';
import '../../../DialogBox/loadingDialog.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class phoneNumberRegister extends StatefulWidget {
  Map<String, dynamic>? allData;
  String? userType;
  String? phoneNumber;

  phoneNumberRegister({Key? key, this.phoneNumber, this.allData, this.userType})
      : super(key: key);

  @override
  State<phoneNumberRegister> createState() => _phoneNumberRegister();
}

class _phoneNumberRegister extends State<phoneNumberRegister> {
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _2FA = TextEditingController();
  int _2fa = 0;
  String? _verificationId;

  @override
  void initState() {
    super.initState();
    if (widget.phoneNumber != null) {
      Future.delayed(Duration.zero).then((value) {
        _phoneNumber.text = widget.phoneNumber!;
        _SignUP();
      });
    }
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          margin: const EdgeInsets.all(5),
                          child: TextField(
                            controller: _phoneNumber,
                            enabled: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Foodi.orangeColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Foodi.orangeColor,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Foodi.orangeColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: PinCodeTextField(
                            appContext: context,
                            length: 6,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedFillColor: Colors.white,
                              activeColor: Foodi.orangeColor,
                              inactiveColor: Colors.grey,
                              selectedColor: Foodi.greenColor,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            controller: _2FA,
                            keyboardType: TextInputType.number,
                            beforeTextPaste: (text) {
                              return true;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_verificationId == null) {
                                _SignUP();
                              } else {
                                _SingIN();
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Foodi.orangeColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 8),
                              child: _verificationId == null
                                  ? const Text(
                                      "Send OTP",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const Text(
                                      "Verify",
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  _SignUP() async {
    showDialog(
      context: context,
      builder: (c) {
        return const LoadingAlertDialog(
          message: "Validating phone number...",
        );
      },
    );

    Complated(PhoneAuthCredential phoneAuthCredential) async {
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      Navigator.pop(context);
    }

    verificationFailed(FirebaseAuthException authException) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) => ErrorAlertDialog(
          message: authException.message.toString(),
        ),
      );
    }

    codeSent(String verificationId, int? resendToken) async {
      Navigator.pop(context);
      setState(() {
        _verificationId = verificationId;
      });
    }

    codeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
    }

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneNumber.text.trim(),
        timeout: const Duration(seconds: 120),
        verificationCompleted: Complated,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (error) {
      Navigator.pop(context);
      print(error.toString());
      showDialog(
        context: context,
        builder: (c) => ErrorAlertDialog(
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _SingIN() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _2FA.text.trim(),
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Hash the password before storing it
        String hashedPassword = await FlutterBcrypt.hashPw(
          password: widget.allData?['password'],
          salt: await FlutterBcrypt.salt(),
        );

        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          'username': widget.allData?['username'],
          'email': widget.allData?['email'],
          'phoneNumber': widget.allData?['phoneNumber'],
          "date": DateTime.now(),
          "password": hashedPassword, // Store the hashed password
          "userRegistered": "true",
          "type": "user",
          "userID": user.uid,
          "status": "Pending",
        }).then((value) {
          Route route = MaterialPageRoute(builder: (_) => const LoginPage());
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        }).catchError((e) {
          showDialog(
            context: context,
            builder: (c) => ErrorAlertDialog(
                message: "Failed to add Data: ${e.toString()},"),
          );
        });
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (c) =>
            ErrorAlertDialog(message: "Failed to Login: ${e.toString()},"),
      );
    }
  }
}

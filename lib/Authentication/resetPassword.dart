// Importing necessary packages for Firebase Authentication, Flutter Material Design, and custom widgets
import 'package:firebase_auth/firebase_auth.dart'; // FirebaseAuth for user authentication
import 'package:flutter/material.dart';
import 'package:foodi/DialogBox/errorDialog.dart';
import 'package:foodi/DialogBox/loadingDialog.dart';
import 'package:foodi/config/config.dart';

// Defining a StatelessWidget 'resetPassword' for a static UI component
class resetPassword extends StatelessWidget {
  // GlobalKey for uniquely identifying the Form widget and managing its state
  // TextEditingController to manage the text the user will enter in the email field
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  // Overriding the build method to describe the UI of the widget
  @override
  Widget build(BuildContext context) {
    // Scaffold as the base layout structure
    return Scaffold(
      extendBody:
          true, // Extending the body behind the app bar and bottom navigation
      resizeToAvoidBottomInset:
          true, // Resizing the body when the keyboard appears

      appBar: AppBar(),
      body: SingleChildScrollView(
        // SingleChildScrollView to make the content scrollable
        child: SafeArea(
          // SafeArea to avoid intrusions by the operating system
          child: Column(
            // Column for vertical arrangement
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // Even spacing between children
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centering children horizontally
            children: [
              Column(
                // Nested Column for the image
                children: [
                  Image.asset(
                    "images/logo.png", // Path to the image asset
                    width: MediaQuery.of(context).size.width *
                        0.8, // Image width as 80% of screen width
                  ),
                ],
              ),
              const SizedBox(
                height: 50, // Fixed height for spacing
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  // Nested Column for the reset password form
                  children: [
                    const Text(
                      "Reset Password", // Text for the form title
                      style: TextStyle(
                          color: Color(0xff4f8caa), // Text color
                          fontSize: 27, // Font size
                          fontWeight: FontWeight.bold), // Font weight
                    ),
                    const SizedBox(
                      height: 20, // Fixed height for spacing
                    ),
                    Column(
                      // Column inside the Form
                      children: [
                        Container(
                          height: 45,
                          margin: const EdgeInsets.all(5),
                          child: TextField(
                            controller: _emailTextEditingController,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              hintText: "Email",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xffc8d2d3),
                                ),
                              ),
                              isCollapsed: false,
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xffc8d2d3),
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.email, // Email icon
                                color: Color(0xff4f8caa), // Icon color
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20, // Fixed height for spacing
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Action when the button is pressed
                        checkIfEmailIsEmpty(
                            context); // Checks if the email field is empty
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Foodi.greenColor),
                      ),
                      child: const Padding(
                        // Padding inside the button
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15), // Padding values
                        child: Text(
                          "Reset", // Text inside the button
                          style: TextStyle(
                            fontSize: 16, // Font size
                            fontWeight: FontWeight.bold, // Font weight
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Function to check if the email field is empty
  checkIfEmailIsEmpty(BuildContext context) {
    _emailTextEditingController.text.isNotEmpty
        ? resetPasswordFun(
            context) // If not empty, proceed to reset password function
        : showDialog(
            // If empty, show error dialog
            context: context,
            builder: (_) => const ErrorAlertDialog(
                message: "Please Put Email"), // Custom error dialog
          );
  }

  // Function to initiate the password reset process
  resetPasswordFun(BuildContext context) {
    showDialog(
      // Show loading dialog
      context: context,
      builder: (_) => const LoadingAlertDialog(
        message: "Resetting Password", // Message for the loading dialog
      ),
    );
    resettingPassword(context); // Call the function to reset the password
  }

  // Function to reset the password using Firebase Authentication
  resettingPassword(context) {
    FirebaseAuth.instance
        .sendPasswordResetEmail(
            email: _emailTextEditingController.text
                .trim()) // Firebase function to send password reset email
        .then(
      (value) {
        Navigator.pop(context); // Close the loading dialog
        showDialog(
          // Show success dialog
          context: context,
          builder: (_) => const ErrorAlertDialog(
              message: "Email were sent"), // Custom success dialog
        );
      },
    ).catchError(
      (error) {
        Navigator.pop(context); // Close the loading dialog
        showDialog(
          // Show error dialog for invalid email
          context: context,
          builder: (_) => const ErrorAlertDialog(
              message:
                  "Please make sure the email is correct"), // Custom error dialog
        );
      },
    );
  }
}

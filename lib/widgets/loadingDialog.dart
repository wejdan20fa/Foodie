import 'package:flutter/material.dart';
import 'package:foodi/config/config.dart';

class LoadingDialogCustom extends StatelessWidget {
  final String
      message; // Store the loading message to be displayed in the dialog.
  const LoadingDialogCustom({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        title: Text(
          message, // Display the loading message received as a parameter.
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Foodi.orangeColor,
              fontSize: 20), // Set text style.
          textAlign: TextAlign.center, // Center-align the text.
        ),
        content: Center(
          child: CircularProgressIndicator(
            color: Foodi.orangeColor,
          ),
        ) // Display a Lottie animation from an asset.
        );
  }
}

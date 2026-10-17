import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String message;

  const ErrorAlertDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xffc8d2d3),
              ),
            ),
            child: const Text(
              "OK",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff4f8caa),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

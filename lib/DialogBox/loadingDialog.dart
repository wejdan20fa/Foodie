import 'package:flutter/material.dart';

class LoadingAlertDialog extends StatelessWidget {
  final String? message;

  const LoadingAlertDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 20.0),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Color(0xff4f8caa),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(message!),
        ],
      ),
    );
  }
}

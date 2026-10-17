import 'package:flutter/material.dart';
import 'package:foodi/Authentication/Register/RegisterPage.dart';
import 'package:foodi/config/config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Positioned top image
          Positioned(
            top: -40,
            left: 0,
            right: 0,
            child: Image.asset('images/2.png', fit: BoxFit.cover),
          ),
          // Centered text and button
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Foodie",
                  style: TextStyle(
                    color: Foodi.orangeColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "The Foods you choose\n make difference",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Foodi.orangeColor),
                  ),
                  onPressed: () {
                    Route route =
                        MaterialPageRoute(builder: (_) => const RegisterPage());
                    Navigator.push(context, route);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned bottom image
          Positioned(
            bottom: 0,
            left: 180,
            right: 0,
            child: Image.asset(
              'images/3.png',
              fit: BoxFit.contain,
              width: 250,
              height: 250,
            ),
          ),
        ],
      ),
    );
  }
}

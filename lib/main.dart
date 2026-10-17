import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodi/Admin/home/homePage.dart';
import 'package:foodi/Authentication/Login/login.dart';
import 'package:foodi/config/config.dart';
import 'package:foodi/firebase_options.dart';
import 'package:foodi/home/chatWithBot/chatWithBot.dart';
import 'package:foodi/home/homeScreen.dart';
import 'package:foodi/splashScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Foodi.sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.dmSerifDisplayTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          Foodi.sharedPreferences?.setString("personalized", "japanese");

          if (snapshot.connectionState == ConnectionState.active) {
            // Checking if the snapshot has data or is null
            User? user = snapshot.data;
            if (user == null) {
              // No user is signed in.
              return SplashScreen();
            } else {
              // User is signed in.
              return HomeScreen(); // Assuming UserHomePage is correctly implemented.
            }
          }
          // While the connection to FirebaseAuth is being established show a loading spinner
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

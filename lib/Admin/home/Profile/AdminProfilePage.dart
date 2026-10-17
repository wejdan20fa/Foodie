import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodi/Admin/home/Profile/adminEditProfile.dart';
import 'package:foodi/Authentication/Login/login.dart';
import 'package:foodi/config/config.dart';

class AdminProfilePage extends StatelessWidget {
  String? currentUser = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    String username = Foodi.sharedPreferences!.getString("username").toString();
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Align(
              alignment:
                  Alignment.topCenter, // Align the rotated image at the top
              child: Image.asset(
                'images/2.png', // Ensure the path to the image is correct
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          // Back button placed above the image layer, within a SafeArea
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // ListView containing the profile information
          SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 80), // Adjust the height as needed
                const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 40, // Adjust the size as needed
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ), // Replace with the user's image
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    username,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(
                      5), // Apply margin around the container
                  child: Center(
                    // Center the button within the available space
                    child: ElevatedButton(
                      onPressed: () {
                        Route route = MaterialPageRoute(
                          builder: (_) => const adminEditProfile(),
                        );
                        Navigator.push(context, route);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Foodi
                              .orangeColor, // Set the background color of the button
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(5.0), // Rounded corners
                          ),
                        ),
                        // Set a fixed size for the button
                        minimumSize: MaterialStateProperty.all(
                            const Size(150, 40)), // Width and height
                      ),
                      child: const Text(
                        "Edit Profile", // Button text
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 20, // Font size
                          fontWeight: FontWeight.bold, // Font weight
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the ListTile
                    borderRadius: BorderRadius.circular(6), // Rounded corners
                    border: Border.all(
                      color: Foodi.orangeColor, // Color of the border
                      width: 1, // Width of the border
                    ),
                  ),
                  margin: const EdgeInsets.only(
                      right: 10, left: 10, top: 5, bottom: 5),
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Delete Account'),
                    onTap: () async {
                      await FirebaseAuth.instance.currentUser
                          ?.delete()
                          .then((value) {
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(currentUser)
                            .delete()
                            .then((value) {
                          Route route = MaterialPageRoute(
                              builder: (_) => const LoginPage());
                          Navigator.pushAndRemoveUntil(
                              context, route, (route) => false);
                        });
                      });
                    },
                  ),
                ),
                // Styled ListTile for Log out
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the ListTile
                    borderRadius: BorderRadius.circular(6), // Rounded corners
                    border: Border.all(
                      color: Foodi.orangeColor, // Color of the border
                      width: 1, // Width of the border
                    ),
                  ),
                  margin: const EdgeInsets.only(
                      right: 10, left: 10, top: 5, bottom: 5),
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Log out'),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut().then((value) {
                        Route route = MaterialPageRoute(
                            builder: (_) => const LoginPage());
                        Navigator.pushAndRemoveUntil(
                            context, route, (route) => false);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodi/Authentication/Login/login.dart';
import 'package:foodi/config/config.dart';
import 'package:foodi/home/Complaints/allComplaints.dart';
import 'package:foodi/home/Proifle/Favorites/AllFavorites.dart';
import 'package:foodi/home/Proifle/editProifle.dart';
import 'package:foodi/home/homeScreen.dart';
import 'package:foodi/home/Proifle/personalizedPreferences/addPersonlaized.dart';
import 'package:foodi/splashScreen.dart';

class ProfilePage extends StatelessWidget {
  String? currentUser = FirebaseAuth.instance.currentUser?.uid;
  String username = Foodi.sharedPreferences!.getString("username") ?? "";

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
          ListView(children: <Widget>[
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
            currentUser != null
                ? Column(
                    children: [
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
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Route route = MaterialPageRoute(
                                builder: (_) => const EditProfilePage(),
                              );
                              Navigator.push(context, route);
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
                              minimumSize: MaterialStateProperty.all(
                                  const Size(150, 40)),
                            ),
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Foodi.orangeColor,
                            width: 1,
                          ),
                        ),
                        margin: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.star),
                          title: const Text('Favourite'),
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const AllFavoritesPage());
                            Navigator.push(context, route);
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Foodi.orangeColor,
                            width: 1,
                          ),
                        ),
                        margin: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('Select personalized preference'),
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) =>
                                    const AddPersonalizedChoicesPage());
                            Navigator.push(context, route);
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Foodi.orangeColor,
                            width: 1,
                          ),
                        ),
                        margin: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.error),
                          title:
                              const Text('Create a complaint about a problem'),
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const ViewComplaintsPage());
                            Navigator.push(context, route);
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Foodi.orangeColor,
                            width: 1,
                          ),
                        ),
                        margin: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 5,
                          bottom: 5,
                        ),
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Foodi.orangeColor,
                            width: 1,
                          ),
                        ),
                        margin: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Log out'),
                          onTap: () async {
                            await FirebaseAuth.instance.signOut().then((value) {
                              Route route = MaterialPageRoute(
                                  builder: (_) => const SplashScreen());
                              Navigator.pushAndRemoveUntil(
                                  context, route, (route) => false);
                            });
                            Foodi.sharedPreferences?.clear();
                          },
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Text(
                              "You Are Not Logged IN, To Login In Click the Home Icon at the top ",
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Route route = MaterialPageRoute(
                                    builder: (_) => const SplashScreen());
                                Navigator.pushAndRemoveUntil(
                                    context, route, (route) => false);
                              },
                              child: const Text("Login"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
          ])
        ],
      ),
    );
  }
}

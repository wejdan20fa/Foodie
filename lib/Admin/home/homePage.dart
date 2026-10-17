import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodi/Admin/home/Profile/AdminProfilePage.dart';
import 'package:foodi/Admin/home/ViewingAllComplaints.dart';
import 'package:foodi/Admin/home/allUser.dart';
import 'package:foodi/Authentication/Login/login.dart';
import 'package:foodi/config/config.dart';
import 'package:foodi/home/Complaints/allComplaints.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Foodi.orangeColor,
        title: const Text(
          "Admin",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Route route = MaterialPageRoute(builder: (_) => LoginPage());
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(15),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          GestureDetector(
            onTap: () {
              Route route = MaterialPageRoute(
                builder: (_) => const AllUsersPage(),
              );
              Navigator.push(context, route);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Foodi.orangeColor,
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "All Users",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Route route = MaterialPageRoute(
                builder: (_) => const ViewingAllComplaints(),
              );
              Navigator.push(context, route);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Foodi.orangeColor,
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "All Complaints",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Route route = MaterialPageRoute(
                builder: (_) => AdminProfilePage(),
              );
              Navigator.push(context, route);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Foodi.orangeColor,
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "About",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

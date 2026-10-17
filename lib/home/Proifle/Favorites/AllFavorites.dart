import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodi/config/config.dart';
import 'package:foodi/home/Proifle/Favorites/RecipeDetailsPage.dart';

class AllFavoritesPage extends StatefulWidget {
  const AllFavoritesPage({Key? key}) : super(key: key);

  @override
  State<AllFavoritesPage> createState() => _AllFavoritesPageState();
}

class _AllFavoritesPageState extends State<AllFavoritesPage> {
  @override
  Widget build(BuildContext context) {
    String? currentUser = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Foodi.greenColor,
        toolbarHeight: 80,
        elevation: 4,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, size: 35, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Favorites",
          style: TextStyle(
            color: Foodi.orangeColor,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('favorites')
              .where("addedBy", isEqualTo: currentUser)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                var recipe = snapshot.data!.docs[index];
                String recipeId = recipe.id;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailsPage(
                            recipeDoc:
                                recipe), // Assuming RecipeDetailsPage is already defined and takes a Firestore document
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/backgroundNo.png"),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.blueGrey,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.22,
                            width: MediaQuery.of(context).size.width * 0.38,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    recipe['name'], // Display the recipe name
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const SizedBox(height: 10),
                                IconButton(
                                  onPressed: () {
                                    delete(recipeId);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  delete(recipeId) async {
    String? currentUser = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection("favorites")
        .doc(recipeId)
        .delete()
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Recipe was deleted from favoritue'),
        duration: Duration(seconds: 2),
      ));
    });
  }
}

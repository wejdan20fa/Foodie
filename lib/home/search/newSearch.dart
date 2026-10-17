import 'package:foodi/config/api_config.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodi/home/search/SearchrecipeDetailes.dart';
import 'package:foodi/model/FoodAPI.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewSearch extends StatefulWidget {
  final String ingredientsInput;

  NewSearch({super.key, required this.ingredientsInput});

  @override
  State<NewSearch> createState() => _NewSearchState();
}

class _NewSearchState extends State<NewSearch> {
  bool currentUser = FirebaseAuth.instance.currentUser?.uid.isNotEmpty ?? false;
  List<Meal> meals = [];
  int visibleMealCount = 2; // Initially, show only 2 meals

  @override
  void initState() {
    super.initState();
    gettingAllData();
  }

  void gettingAllData() async {
    String url = "www.themealdb.com";
    String path = '/api/json/v1/1/search.php';
    var parameters = {'s': widget.ingredientsInput};

    Uri uri = Uri.https(url, path, parameters);

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var fetchedMeals = List<Meal>.from(
            jsonData['meals'].map((model) => Meal.fromJson(model)).toList());
        setState(() {
          meals = fetchedMeals;
        });
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("This is the error: $e");
    }
    final GettingDataUsingAI = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key=${ApiConfig.geminiApiKey}');
    final requestHeaders = {'Content-Type': 'application/json'};
    final requestBody = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": "write recipe for ${widget.ingredientsInput}:\n"},
            {
              "inlineData": {"mimeType": "image/jpeg", "data": ""}
            },
            {
              "text":
                  "system_instruction = \"\\n\\nfollow these:\\n1. everything will be uploaded is food ingredients.\\n2. detect the food ingredients.\\n3. just write the name of the food ingredients. nothing else.\\n4. example: onion.\\n\\n\""
            }
          ]
        }
      ],
      "generationConfig": {
        "temperature": 0.4,
        "topK": 32,
        "topP": 1,
        "maxOutputTokens": 4096,
        "stopSequences": []
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Search"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: visibleMealCount,
              itemBuilder: (context, index) {
                if (index >= meals.length) return Container();
                Meal meal = meals[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MealDetailsPage(meal: meal),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.22,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("images/backgroundNo.png"),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.grey.withOpacity(0.2)),
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
                                Text(
                                  meal.strMeal ?? "Unknown Meal",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.favorite,
                                      color: Colors.red[400]),
                                  onPressed: () {
                                    currentUser
                                        ? addToFavorites(meal)
                                        : ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "You Need To Login First")),
                                          );
                                  },
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
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                visibleMealCount +=
                    2; // Show 2 more meals each time button is pressed
              });
            },
            child: const Text("Show More Recipes"),
          ),
        ],
      ),
    );
  }

  void addToFavorites(Meal meal) async {
    String? currentUser = FirebaseAuth.instance.currentUser?.uid;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User must be logged in to add favorites")));
      return;
    }

    // Check if the meal is already favorited
    var existingMeal = await FirebaseFirestore.instance
        .collection('favorites')
        .where('id', isEqualTo: meal.idMeal.toString())
        .where('addedBy', isEqualTo: currentUser)
        .get();

    if (existingMeal.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${meal.strMeal} is already in favorites.")));
      return;
    }

    try {
      await FirebaseFirestore.instance.collection("favorites").add({
        'name': meal.strMeal,
        'id': meal.idMeal.toString(), // Ensure id is a string
        'ingredients': meal.ingredients?.join(', '),
        'instructions': meal.strInstructions
                ?.split(new RegExp(r"\. |\.\n"))
                .where((point) => point.trim().isNotEmpty)
                .toList() ??
            ["No instructions"],
        'addedBy': currentUser,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${meal.strMeal} added to favorites!'),
          duration: const Duration(seconds: 2),
        ));
      });
    } catch (e) {
      print("Failed to add to favorites: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add ${meal.strMeal} to favorites.'),
        duration: const Duration(seconds: 2),
      ));
    }
  }
}

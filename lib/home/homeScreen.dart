import 'package:foodi/config/api_config.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodi/home/EnterIngredients/enterIngredent.dart';
import 'package:foodi/home/Proifle/ProfilePage.dart';
import 'package:foodi/home/Recomnded/recipeDetailes.dart';
import 'package:foodi/home/chatWithBot/chatWithBot.dart';
import 'package:foodi/home/search/newSearch.dart';
import 'package:foodi/model/FoodAPI.dart';
import 'package:http/http.dart' as http;
import 'package:foodi/config/config.dart';
import 'package:foodi/splashScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final TextEditingController _search = TextEditingController();
  List<RecipeDetail> meals = []; // Holds the fetched meals
  List<RecipeDetail> limitedMeals = [];
  Set<String> favoriteMealIds =
      Set(); // This will hold the IDs of favorite meals

  int mealsCount = 3; // Initial count of meals to display

  String apiKey = ApiConfig.spoonacularApiKey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    gettingAllData(); // Fetch meals when the screen initializes
    updateFavoriteMealIds(); // Fetch favorite meals on init
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void addToMealsCount() {
    setState(() {
      mealsCount += 3; // Increment meals count by 5
      showingMoreMeals(); // Update the meals to show
    });
  }

  Future<void> updateFavoriteMealIds() async {
    var currentUser = FirebaseAuth.instance.currentUser?.uid;
    if (currentUser != null) {
      var data = await FirebaseFirestore.instance
          .collection("favorites")
          .where("addedBy", isEqualTo: currentUser)
          .get();
      setState(() {
        favoriteMealIds = Set.from(data.docs.map((doc) => doc['id']));
      });
    }
  }

  void showingMoreMeals() {
    setState(() {
      limitedMeals = meals
          .take(mealsCount)
          .toList(); // Show only a limited number of meals
    });
  }

  void gettingAllData() async {
    // Retrieve personalized areas, allergies, and diseases from shared preferences
    String personalizedAreas =
        Foodi.sharedPreferences?.getString("personalized")?.toLowerCase() ??
            "japanese";
    List<String> allergies = Foodi.sharedPreferences
            ?.getStringList("allergies")
            ?.map((e) => e.toLowerCase())
            .toList() ??
        [];
    List<String> diseases = Foodi.sharedPreferences
            ?.getStringList("diseases")
            ?.map((e) => e.toLowerCase())
            .toList() ??
        [];

    // Construct the base URL and parameters for the API request
    String url = "api.spoonacular.com";
    String path = 'recipes/random';
    Map<String, String> parameters = {
      'number': '100',
      'apiKey': apiKey,
      'tags': personalizedAreas
    };

    // If there is a search term, add it to the parameters
    if (_search.text.isNotEmpty) {
      parameters['query'] = _search.text;
    }

    Uri uri = Uri.https(url, path, parameters);

    try {
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['recipes'] != null) {
          var fetchedMeals = List<RecipeDetail>.from(jsonData['recipes']
              .map((model) => RecipeDetail.fromJson(model))
              .toList());

          // Filter recipes based on allergies and diseases
          List<RecipeDetail> filteredMeals = fetchedMeals.where((meal) {
            // true or false
            bool containsAllergens = meal.extendedIngredients?.any(
                    (ingredient) => allergies
                        .contains(ingredient.name?.toLowerCase() ?? "")) ??
                false;
            bool matchesDiseaseDiet = diseases.every((disease) =>
                meal.diets?.contains(disease.toLowerCase()) ?? false);
            return !containsAllergens && matchesDiseaseDiet;
          }).toList();

          // Filter and randomize meals as necessary
          List<RecipeDetail> personalizedMeals = [];
          List<RecipeDetail> otherMeals = [];

          for (var meal in filteredMeals) {
            if (meal.cuisines != null &&
                meal.cuisines!.any((cuisine) =>
                    personalizedAreas.contains(cuisine.toLowerCase()))) {
              personalizedMeals.add(meal);
            } else {
              otherMeals.add(meal);
            }
          }

          otherMeals.shuffle(); // Shuffle non-personalized meals

          // Update state to display meals
          setState(() {
            meals = [...personalizedMeals, ...otherMeals];
            showingMoreMeals();
          });
        } else {
          print("No 'recipes' data found in API response.");
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching meals: $e");
    }
  }

  final GettingDataUsingAI = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key=${ApiConfig.geminiApiKey}');
  final requestHeaders = {'Content-Type': 'application/json'};
  final requestBody = jsonEncode({
    "contents": [
      {
        "parts": [
          {"text": "what ingredients in the }:\n"},
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

  @override
  Widget build(BuildContext context) {
    bool currentUser =
        FirebaseAuth.instance.currentUser?.uid.isNotEmpty ?? false;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          currentUser
                              ? IconButton(
                                  onPressed: () {
                                    Route route = MaterialPageRoute(
                                        builder: (_) => const HomeScreen());
                                    Navigator.push(context, route);
                                  },
                                  icon: const Icon(Icons.home,
                                      size: 35, color: Colors.black),
                                )
                              : IconButton(
                                  onPressed: () {
                                    Route route = MaterialPageRoute(
                                        builder: (_) => const SplashScreen());
                                    Navigator.pushAndRemoveUntil(
                                        context, route, (route) => false);
                                  },
                                  icon: const Icon(Icons.home,
                                      size: 35, color: Colors.black),
                                ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()),
                              ).then((_) {
                                gettingAllData();
                              });
                            },
                            icon: const Icon(Icons.person,
                                size: 35, color: Colors.black),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: TextField(
                          controller: _search,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Foodi.orangeColor),
                            ),
                            hintText: "Type Recipe Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide.none,
                            ),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewSearch(
                                        ingredientsInput: _search.text),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (_) => const EnterIngredients());
                          Navigator.push(context, route);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: Foodi.greenColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: ListTile(
                                  title: const Text(
                                    "Enter Ingredients",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  trailing: Image.asset("images/food.png"),
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  void goTo() {
                                    Route route = MaterialPageRoute(
                                        builder: (_) => ChatWithBot());
                                    Navigator.push(context, route);
                                  }

                                  currentUser
                                      ? goTo()
                                      : ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "You Need To Login To use the chatbot"),
                                          ),
                                        );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Foodi.orangeColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: const ListTile(
                                    title: Text(
                                      "Chat with Foodie to find Alternative ingredients and suggest lunch boxes",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    trailing: Icon(Icons.smart_toy_outlined,
                                        color: Colors.black, size: 45),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recommended For You",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: limitedMeals.length,
                          itemBuilder: (context, index) {
                            RecipeDetail meal = limitedMeals[index];
                            int? mealID = meal.id;

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MealDetailsPage(meal: meal),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("images/backgroundNo.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.38,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.4),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              meal.title ?? "Unknown Meal",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  Shadow(
                                                    offset: Offset(0, 2),
                                                    blurRadius: 4.0,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: IconButton(
                                                onPressed: () {
                                                  if (favoriteMealIds
                                                      .contains(meal.id)) {
                                                    // Handling already favorited meals
                                                  } else {
                                                    addToFavorites(meal);
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.favorite,
                                                ),
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
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          addToMealsCount();
                        },
                        child: Text("Show More Recipes ",
                            style: TextStyle(color: Foodi.orangeColor)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addToFavorites(RecipeDetail meal) async {
    String? currentUser = FirebaseAuth.instance.currentUser?.uid;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User must be logged in to add favorites")));
      return;
    }

    // Check if the meal is already favorited
    var existingMeal = await FirebaseFirestore.instance
        .collection('favorites')
        .where('id', isEqualTo: meal.id.toString()) // Ensure id is a string
        .where('addedBy', isEqualTo: currentUser)
        .get();

    if (existingMeal.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${meal.title} is already in favorites.")));
      return;
    }

    try {
      await FirebaseFirestore.instance.collection("favorites").add({
        'name': meal.title ?? "No title",
        'id': meal.id.toString(), // Ensure id is a string
        'ingredients': meal.extendedIngredients
                ?.map((ingredient) => ingredient.name)
                .toList() ??
            [],
        'addedBy': currentUser,
        'instructions': meal.instructions
                ?.split(new RegExp(r"\. |\.\n"))
                .where((point) => point.trim().isNotEmpty)
                .toList() ??
            ["No instructions"],
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${meal.title} added to favorites!'),
          duration: const Duration(seconds: 2),
        ));
        updateFavoriteMealIds();
      });
    } catch (e) {
      print("Failed to add to favorites: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add ${meal.title} to favorites.'),
        duration: const Duration(seconds: 2),
      ));
    }
  }
}

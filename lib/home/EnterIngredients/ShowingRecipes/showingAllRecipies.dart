import 'package:foodi/config/api_config.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:foodi/config/config.dart';
import 'package:foodi/home/EnterIngredients/enterIngredent.dart';
import 'package:foodi/home/Proifle/ProfilePage.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;

class showingAllRecipies extends StatefulWidget {
  List<String> IngredientsInput;
  showingAllRecipies({super.key, required this.IngredientsInput});

  @override
  State<showingAllRecipies> createState() => _showingAllRecipiesState();
}

class _showingAllRecipiesState extends State<showingAllRecipies> {
  List<Map<String, dynamic>> _recipes = []; // To store fetched recipes
  String _generatedContent = ""; // To store generated content
  String? ttt;
  bool _loading = false;
  List<String> requiredKeys = [
    'title',
    'cuisine',
    'time',
    'ingredients',
    'instructions',
    'tips'
  ];

  @override
  void initState() {
    super.initState();
    generateContent(widget.IngredientsInput);
  }

  generateContent(List<String> ingredients) async {
    final model = GenerativeModel(
        model: 'gemini-1.0-pro',
        apiKey: ApiConfig.geminiApiKey);

    var ingredientString = ingredients.join(", ");
    var requiredKeys =
        "Ingredients, Instructions"; // Define the sections you expect in the recipe.

    // Construct a clearer and more direct prompt.
    var prompt =
        "Generate recipes using only the following ingredients: ${ingredientString}. " +
            "Do not include any additional ingredients that are not part of ${ingredientString}. " +
            "Each recipe should include sections for ${requiredKeys}.";

    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    // Parse the generated content into recipe format.
    _recipes = parseGeneratedContent(response.text!);
    String jsonRecipes = jsonEncode(_recipes);
    await Clipboard.setData(ClipboardData(text: jsonRecipes));
    print("Recipes: ${_recipes}");

    setState(() {
      _loading = false; // Set loading to false as the process is complete.
    });
  }

  List<Map<String, dynamic>> parseGeneratedContent(String content) {
    List<Map<String, dynamic>> recipes = [];
    List<String> lines = content.split('\n');

    Map<String, dynamic> currentRecipe = {};
    String currentKey = '';

    for (String line in lines) {
      line = line.trim();
      if (line.startsWith('**')) {
        if (!currentRecipe.isEmpty) {
          recipes.add(new Map<String, dynamic>.from(currentRecipe));
          currentRecipe.clear();
        }
        currentKey =
            line.substring(2).trim(); // Remove '**' and trim whitespace
        currentRecipe[currentKey] = '';
      } else if (currentKey.isNotEmpty) {
        if (currentRecipe[currentKey].isEmpty) {
          currentRecipe[currentKey] = line;
        } else {
          currentRecipe[currentKey] += '\n' + line;
        }
      }
    }

    if (!currentRecipe.isEmpty) {
      recipes.add(currentRecipe);
    }

    return recipes;
  }

  @override
  Widget build(BuildContext context) {
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.person, size: 35, color: Colors.black),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ProfilePage()));
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 8,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: SafeArea(
                child: !_loading // Corrected the condition here
                    ? ListView.builder(
                        itemCount: _recipes.length,
                        itemBuilder: (context, index) {
                          var recipe = _recipes[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: recipe.entries.map(
                                  (entry) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          entry.key,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(entry.value),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: Foodi.orangeColor,
                        ),
                      ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  generateContent(widget.IngredientsInput);
                  setState(() {
                    _loading = true;
                  });
                },
                child: Text(
                  "Show more recipes...",
                  style: TextStyle(
                    color: Foodi.orangeColor,
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

import 'package:flutter/material.dart';

class recipeDetailes extends StatelessWidget {
  final Map<String, dynamic> recipe; // Assuming the recipe is stored as a map

  const recipeDetailes({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title']),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Time to cook: ${recipe['time']}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Ingredients:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(recipe['ingredients']), // Assuming ingredients is a string
              const SizedBox(height: 10),
              const Text(
                "Steps:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(recipe['steps']), // Assuming steps is a string
            ],
          ),
        ),
      ),
    );
  }
}

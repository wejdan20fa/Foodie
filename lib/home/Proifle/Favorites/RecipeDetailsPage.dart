import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeDetailsPage extends StatelessWidget {
  final DocumentSnapshot recipeDoc;

  const RecipeDetailsPage({Key? key, required this.recipeDoc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access data safely and provide fallbacks if necessary
    Map<String, dynamic> data = recipeDoc.data() as Map<String, dynamic>? ?? {};

    // Handle ingredients; ensuring it is a list
    List<dynamic> ingredients = [];
    if (data['ingredients'] != null) {
      ingredients = data['ingredients'] is List
          ? List.from(data['ingredients'])
          : [data['ingredients'].toString()];
    }

    // Handle instructions; ensuring it is a list
    List<dynamic> instructionPoints = [];
    if (data['instructions'] != null) {
      instructionPoints = data['instructions'] is List
          ? List.from(data['instructions'])
          : [data['instructions'].toString()];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(data.containsKey('name')
            ? data['name'] ?? "Recipe Details"
            : "Recipe Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.kitchen,
                    color: Theme.of(context).colorScheme.secondary),
                const SizedBox(width: 8),
                const Text("Ingredients",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            ...ingredients
                .map((ingredient) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(ingredient.toString(),
                          style: TextStyle(fontSize: 16)),
                    ))
                .toList(),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.description,
                    color: Theme.of(context).colorScheme.secondary),
                const SizedBox(width: 8),
                const Text("Instructions",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            ...instructionPoints
                .where((point) => point.toString().trim().isNotEmpty)
                .map(
                  (point) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text("• ${point.toString()}",
                        style: const TextStyle(height: 2, fontSize: 16)),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

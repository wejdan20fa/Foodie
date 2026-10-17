import 'package:flutter/material.dart';
import 'package:foodi/model/FoodAPI.dart'; // Ensure this path is correct and contains the RecipeDetail model

class MealDetailsPage extends StatelessWidget {
  final RecipeDetail
      meal; // Assuming RecipeDetail is the correct detailed class

  const MealDetailsPage({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Assuming 'extendedIngredients' is a List of ingredients objects and we're extracting 'original' string
    List<String> ingredients = meal.extendedIngredients
            ?.map((e) => removeHtmlTags(e.original ?? ''))
            .toList() ??
        [];

    // Since 'instructions' is assumed to be a single string, we split it into points here.
    List<String> instructionPoints = removeHtmlTags(meal.instructions ?? '')
        .split(RegExp(r'\. |\.\n'))
        .where((s) => s.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title ?? "Meal Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ingredients section
            buildSectionTitle(context, "Ingredients"),
            const SizedBox(height: 10),
            // Displaying each ingredient with proper null check.
            ...ingredients.map((ingredient) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(ingredient),
                )),
            const SizedBox(height: 20),
            // Instructions section
            buildSectionTitle(context, "Instructions"),
            const SizedBox(height: 10),
            // Displaying each instruction point safely.
            ...instructionPoints.map((point) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text("• $point", style: const TextStyle(height: 1.5)),
                )),
          ],
        ),
      ),
    );
  }

  // Helper function to build section titles
  Widget buildSectionTitle(BuildContext context, String text) {
    return Row(
      children: [
        Icon(Icons.description, color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Function to remove HTML tags from a string
  String removeHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false);
    return htmlString.replaceAll(exp, '');
  }
}

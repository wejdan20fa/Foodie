import 'package:flutter/material.dart';
import 'package:foodi/home/search/newSearch.dart';
import 'package:foodi/model/FoodAPI.dart';

class MealDetailsPage extends StatelessWidget {
  final Meal meal;

  const MealDetailsPage({Key? key, required this.meal}) : super(key: key);

  Widget build(BuildContext context) {
    // Using the ingredients directly from the Meal object
    List<String> ingredients = meal.ingredients ?? [];

    List<String> instructionPoints =
        meal.strInstructions?.split(RegExp(r"\. |\.\n")) ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.strMeal ?? "Meal Details"),
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
                      child: Text(ingredient),
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
                .where((point) => point.trim().isNotEmpty)
                .map((point) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child:
                          Text("• $point", style: const TextStyle(height: 1.5)),
                    )),
          ],
        ),
      ),
    );
  }
}

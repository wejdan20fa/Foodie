// class Meals {
//   String? idMeal;
//   String? strMeal;
//   String? strDrinkAlternate; // Changed from Null to String?
//   String? strCategory;
//   String? strArea;
//   String? strInstructions;
//   String? strMealThumb;
//   String? strTags;
//   String? strYoutube;
//   String? strIngredient1;
//   String? strIngredient2;
//   String? strIngredient3;
//   String? strIngredient4;
//   String? strIngredient5;
//   String? strIngredient6;
//   String? strIngredient7;
//   String? strIngredient8;
//   String? strIngredient9;
//   String? strIngredient10;
//   String? strIngredient11;
//   String? strIngredient12;
//   String? strIngredient13;
//   String? strIngredient14;
//   String? strIngredient15;
//   String? strIngredient16;
//   String? strIngredient17;
//   String? strIngredient18;
//   String? strIngredient19;
//   String? strIngredient20;
//   String? strMeasure1;
//   String? strMeasure2;
//   String? strMeasure3;
//   String? strMeasure4;
//   String? strMeasure5;
//   String? strMeasure6;
//   String? strMeasure7;
//   String? strMeasure8;
//   String? strMeasure9;
//   String? strMeasure10;
//   String? strMeasure11;
//   String? strMeasure12;
//   String? strMeasure13;
//   String? strMeasure14;
//   String? strMeasure15;
//   String? strMeasure16;
//   String? strMeasure17;
//   String? strMeasure18;
//   String? strMeasure19;
//   String? strMeasure20;
//   String? strSource;
//   String? strImageSource;
//   String? strCreativeCommonsConfirmed;
//   String? dateModified;

//   Meals(
//       {this.idMeal,
//       this.strMeal,
//       this.strDrinkAlternate,
//       this.strCategory,
//       this.strArea,
//       this.strInstructions,
//       this.strMealThumb,
//       this.strTags,
//       this.strYoutube,
//       this.strIngredient1,
//       this.strIngredient2,
//       this.strIngredient3,
//       this.strIngredient4,
//       this.strIngredient5,
//       this.strIngredient6,
//       this.strIngredient7,
//       this.strIngredient8,
//       this.strIngredient9,
//       this.strIngredient10,
//       this.strIngredient11,
//       this.strIngredient12,
//       this.strIngredient13,
//       this.strIngredient14,
//       this.strIngredient15,
//       this.strIngredient16,
//       this.strIngredient17,
//       this.strIngredient18,
//       this.strIngredient19,
//       this.strIngredient20,
//       this.strMeasure1,
//       this.strMeasure2,
//       this.strMeasure3,
//       this.strMeasure4,
//       this.strMeasure5,
//       this.strMeasure6,
//       this.strMeasure7,
//       this.strMeasure8,
//       this.strMeasure9,
//       this.strMeasure10,
//       this.strMeasure11,
//       this.strMeasure12,
//       this.strMeasure13,
//       this.strMeasure14,
//       this.strMeasure15,
//       this.strMeasure16,
//       this.strMeasure17,
//       this.strMeasure18,
//       this.strMeasure19,
//       this.strMeasure20,
//       this.strSource,
//       this.strImageSource,
//       this.strCreativeCommonsConfirmed,
//       this.dateModified});

//   Meals.fromJson(Map<String, dynamic> json) {
//     idMeal = json['idMeal'];
//     strMeal = json['strMeal'];
//     strDrinkAlternate = json['strDrinkAlternate'];
//     strCategory = json['strCategory'];
//     strArea = json['strArea'];
//     strInstructions = json['strInstructions'];
//     strMealThumb = json['strMealThumb'];
//     strTags = json['strTags'];
//     strYoutube = json['strYoutube'];
//     strIngredient1 = json['strIngredient1'];
//     strIngredient2 = json['strIngredient2'];
//     strIngredient3 = json['strIngredient3'];
//     strIngredient4 = json['strIngredient4'];
//     strIngredient5 = json['strIngredient5'];
//     strIngredient6 = json['strIngredient6'];
//     strIngredient7 = json['strIngredient7'];
//     strIngredient8 = json['strIngredient8'];
//     strIngredient9 = json['strIngredient9'];
//     strIngredient10 = json['strIngredient10'];
//     strIngredient11 = json['strIngredient11'];
//     strIngredient12 = json['strIngredient12'];
//     strIngredient13 = json['strIngredient13'];
//     strIngredient14 = json['strIngredient14'];
//     strIngredient15 = json['strIngredient15'];
//     strIngredient16 = json['strIngredient16'];
//     strIngredient17 = json['strIngredient17'];
//     strIngredient18 = json['strIngredient18'];
//     strIngredient19 = json['strIngredient19'];
//     strIngredient20 = json['strIngredient20'];
//     strMeasure1 = json['strMeasure1'];
//     strMeasure2 = json['strMeasure2'];
//     strMeasure3 = json['strMeasure3'];
//     strMeasure4 = json['strMeasure4'];
//     strMeasure5 = json['strMeasure5'];
//     strMeasure6 = json['strMeasure6'];
//     strMeasure7 = json['strMeasure7'];
//     strMeasure8 = json['strMeasure8'];
//     strMeasure9 = json['strMeasure9'];
//     strMeasure10 = json['strMeasure10'];
//     strMeasure11 = json['strMeasure11'];
//     strMeasure12 = json['strMeasure12'];
//     strMeasure13 = json['strMeasure13'];
//     strMeasure14 = json['strMeasure14'];
//     strMeasure15 = json['strMeasure15'];
//     strMeasure16 = json['strMeasure16'];
//     strMeasure17 = json['strMeasure17'];
//     strMeasure18 = json['strMeasure18'];
//     strMeasure19 = json['strMeasure19'];
//     strMeasure20 = json['strMeasure20'];
//     strSource = json['strSource'];
//     strImageSource = json['strImageSource'];
//     strCreativeCommonsConfirmed = json['strCreativeCommonsConfirmed'];
//     dateModified = json['dateModified'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['idMeal'] = idMeal;
//     data['strMeal'] = strMeal;
//     data['strDrinkAlternate'] = strDrinkAlternate;
//     data['strCategory'] = strCategory;
//     data['strArea'] = strArea;
//     data['strInstructions'] = strInstructions;
//     data['strMealThumb'] = strMealThumb;
//     data['strTags'] = strTags;
//     data['strYoutube'] = strYoutube;
//     data['strIngredient1'] = strIngredient1;
//     data['strIngredient2'] = strIngredient2;
//     data['strIngredient3'] = strIngredient3;
//     data['strIngredient4'] = strIngredient4;
//     data['strIngredient5'] = strIngredient5;
//     data['strIngredient6'] = strIngredient6;
//     data['strIngredient7'] = strIngredient7;
//     data['strIngredient8'] = strIngredient8;
//     data['strIngredient9'] = strIngredient9;
//     data['strIngredient10'] = strIngredient10;
//     data['strIngredient11'] = strIngredient11;
//     data['strIngredient12'] = strIngredient12;
//     data['strIngredient13'] = strIngredient13;
//     data['strIngredient14'] = strIngredient14;
//     data['strIngredient15'] = strIngredient15;
//     data['strIngredient16'] = strIngredient16;
//     data['strIngredient17'] = strIngredient17;
//     data['strIngredient18'] = strIngredient18;
//     data['strIngredient19'] = strIngredient19;
//     data['strIngredient20'] = strIngredient20;
//     data['strMeasure1'] = strMeasure1;
//     data['strMeasure2'] = strMeasure2;
//     data['strMeasure3'] = strMeasure3;
//     data['strMeasure4'] = strMeasure4;
//     data['strMeasure5'] = strMeasure5;
//     data['strMeasure6'] = strMeasure6;
//     data['strMeasure7'] = strMeasure7;
//     data['strMeasure8'] = strMeasure8;
//     data['strMeasure9'] = strMeasure9;
//     data['strMeasure10'] = strMeasure10;
//     data['strMeasure11'] = strMeasure11;
//     data['strMeasure12'] = strMeasure12;
//     data['strMeasure13'] = strMeasure13;
//     data['strMeasure14'] = strMeasure14;
//     data['strMeasure15'] = strMeasure15;
//     data['strMeasure16'] = strMeasure16;
//     data['strMeasure17'] = strMeasure17;
//     data['strMeasure18'] = strMeasure18;
//     data['strMeasure19'] = strMeasure19;
//     data['strMeasure20'] = strMeasure20;
//     data['strSource'] = strSource;
//     data['strImageSource'] = strImageSource;
//     data['strCreativeCommonsConfirmed'] = strCreativeCommonsConfirmed;
//     data['dateModified'] = dateModified;
//     return data;
//   }

//   List<String> getIngredientsAndMeasurements() {
//     List<String> combined = [];
//     List<String?> ingredients = [
//       strIngredient1, strIngredient2,
//       strIngredient3, // ... up to strIngredient20
//     ];
//     List<String?> measurements = [
//       strMeasure1, strMeasure2, strMeasure3, // ... up to strMeasure20
//     ];

//     for (int i = 0; i < ingredients.length; i++) {
//       if (ingredients[i] != null && ingredients[i]!.isNotEmpty) {
//         String ingredient = ingredients[i]!;
//         String measure = measurements[i] ?? "";
//         combined.add("$ingredient: $measure");
//       }
//     }

//     return combined;
//   }
// }

class Recipe {
  final List<RecipeDetail>? recipes;

  Recipe({this.recipes});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipes: json['recipes'] != null
          ? List<RecipeDetail>.from(
              json['recipes'].map((x) => RecipeDetail.fromJson(x)))
          : null,
    );
  }
}

class RecipeDetail {
  bool? vegetarian;
  bool? vegan;
  bool? glutenFree;
  bool? dairyFree;
  bool? veryHealthy;
  bool? cheap;
  bool? veryPopular;
  bool? sustainable;
  bool? lowFodmap;
  int? weightWatcherSmartPoints;
  String? gaps;
  int? preparationMinutes;
  int? cookingMinutes;
  int? aggregateLikes;
  int? healthScore;
  String? creditsText;
  String? license;
  String? sourceName;
  double? pricePerServing;
  List<ExtendedIngredient>? extendedIngredients;
  int? id;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;
  String? image;
  String? imageType;
  String? summary;
  List<String>? cuisines;
  List<String>? dishTypes;
  List<String>? diets;
  List<String>? occasions;
  String? instructions;
  List<AnalyzedInstruction>? analyzedInstructions;

  RecipeDetail({
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.lowFodmap,
    this.weightWatcherSmartPoints,
    this.gaps,
    this.preparationMinutes,
    this.cookingMinutes,
    this.aggregateLikes,
    this.healthScore,
    this.creditsText,
    this.license,
    this.sourceName,
    this.pricePerServing,
    this.extendedIngredients,
    this.id,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    this.image,
    this.imageType,
    this.summary,
    this.cuisines,
    this.dishTypes,
    this.diets,
    this.occasions,
    this.instructions,
    this.analyzedInstructions,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
      vegetarian: json['vegetarian'],
      vegan: json['vegan'],
      glutenFree: json['glutenFree'],
      dairyFree: json['dairyFree'],
      veryHealthy: json['veryHealthy'],
      cheap: json['cheap'],
      veryPopular: json['veryPopular'],
      sustainable: json['sustainable'],
      lowFodmap: json['lowFodmap'],
      weightWatcherSmartPoints: json['weightWatcherSmartPoints'],
      gaps: json['gaps'],
      preparationMinutes: json['preparationMinutes'],
      cookingMinutes: json['cookingMinutes'],
      aggregateLikes: json['aggregateLikes'],
      healthScore: json['healthScore'],
      creditsText: json['creditsText'],
      license: json['license'],
      sourceName: json['sourceName'],
      pricePerServing: json['pricePerServing'].toDouble(),
      extendedIngredients: json['extendedIngredients'] != null
          ? List<ExtendedIngredient>.from(json['extendedIngredients']
              .map((x) => ExtendedIngredient.fromJson(x)))
          : null,
      id: json['id'],
      title: json['title'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      sourceUrl: json['sourceUrl'],
      image: json['image'],
      imageType: json['imageType'],
      summary: json['summary'],
      cuisines: List<String>.from(json['cuisines'].map((x) => x)),
      dishTypes: List<String>.from(json['dishTypes'].map((x) => x)),
      diets: List<String>.from(json['diets'].map((x) => x)),
      occasions: List<String>.from(json['occasions'].map((x) => x)),
      instructions: json['instructions'],
      analyzedInstructions: json['analyzedInstructions'] != null
          ? List<AnalyzedInstruction>.from(json['analyzedInstructions']
              .map((x) => AnalyzedInstruction.fromJson(x)))
          : null,
    );
  }
}

class ExtendedIngredient {
  int? id;
  String? aisle;
  String? image;
  String? consistency;
  String? name;
  String? nameClean;
  String? original;
  String? originalName;
  double? amount;
  String? unit;
  List<dynamic>? meta;
  Measures? measures;

  ExtendedIngredient({
    this.id,
    this.aisle,
    this.image,
    this.consistency,
    this.name,
    this.nameClean,
    this.original,
    this.originalName,
    this.amount,
    this.unit,
    this.meta,
    this.measures,
  });

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) {
    return ExtendedIngredient(
      id: json['id'],
      aisle: json['aisle'],
      image: json['image'],
      consistency: json['consistency'],
      name: json['name'],
      nameClean: json['nameClean'],
      original: json['original'],
      originalName: json['originalName'],
      amount: json['amount'].toDouble(),
      unit: json['unit'],
      meta: List<dynamic>.from(json['meta'].map((x) => x)),
      measures: Measures.fromJson(json['measures']),
    );
  }
}

class Measures {
  UsMetric? us;
  UsMetric? metric;

  Measures({this.us, this.metric});

  factory Measures.fromJson(Map<String, dynamic> json) {
    return Measures(
      us: UsMetric.fromJson(json['us']),
      metric: UsMetric.fromJson(json['metric']),
    );
  }
}

class UsMetric {
  double? amount;
  String? unitShort;
  String? unitLong;

  UsMetric({this.amount, this.unitShort, this.unitLong});

  factory UsMetric.fromJson(Map<String, dynamic> json) {
    return UsMetric(
      amount: json['amount'].toDouble(),
      unitShort: json['unitShort'],
      unitLong: json['unitLong'],
    );
  }
}

class AnalyzedInstruction {
  String? name;
  List<InstructionStep>? steps;

  AnalyzedInstruction({this.name, this.steps});

  factory AnalyzedInstruction.fromJson(Map<String, dynamic> json) {
    return AnalyzedInstruction(
      name: json['name'],
      steps: json['steps'] != null
          ? List<InstructionStep>.from(
              json['steps'].map((x) => InstructionStep.fromJson(x)))
          : null,
    );
  }
}

class InstructionStep {
  int? number;
  String? step;
  List<Ingredient>? ingredients;
  List<Equipment>? equipment;
  Length? length;

  InstructionStep({
    this.number,
    this.step,
    this.ingredients,
    this.equipment,
    this.length,
  });

  factory InstructionStep.fromJson(Map<String, dynamic> json) {
    return InstructionStep(
      number: json['number'],
      step: json['step'],
      ingredients: json['ingredients'] != null
          ? List<Ingredient>.from(
              json['ingredients'].map((x) => Ingredient.fromJson(x)))
          : null,
      equipment: json['equipment'] != null
          ? List<Equipment>.from(
              json['equipment'].map((x) => Equipment.fromJson(x)))
          : null,
      length: json['length'] != null ? Length.fromJson(json['length']) : null,
    );
  }
}

class Ingredient {
  int? id;
  String? name;
  String? localizedName;
  String? image;

  Ingredient({this.id, this.name, this.localizedName, this.image});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      localizedName: json['localizedName'],
      image: json['image'],
    );
  }
}

class Equipment {
  int? id;
  String? name;
  String? localizedName;
  String? image;

  Equipment({this.id, this.name, this.localizedName, this.image});

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'],
      name: json['name'],
      localizedName: json['localizedName'],
      image: json['image'],
    );
  }
}

class Length {
  int? number;
  String? unit;

  Length({this.number, this.unit});

  factory Length.fromJson(Map<String, dynamic> json) {
    return Length(
      number: json['number'],
      unit: json['unit'],
    );
  }
}

class Meal {
  final String? strMeal;
  final int? cookTime;
  final String? idMeal;
  final String? strInstructions;
  final List<String>?
      ingredients; // Existing list, might be used differently or removed depending on the structure

  // Adding placeholders for individual ingredients and measurements
  final String? strIngredient1,
      strIngredient2,
      strIngredient3; // Add up to strIngredient20
  final String? strMeasure1, strMeasure2, strMeasure3; // Add up to strMeasure20

  Meal({
    this.strMeal,
    this.cookTime,
    this.idMeal,
    this.strInstructions,
    this.ingredients, // You might consider removing this if switching to individual fields
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3, // Continue with constructor parameters
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3, // Continue with constructor parameters
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add("$ingredient: $measure");
      }
    }

    return Meal(
      strMeal: json['strMeal'],
      cookTime: json['cookTime'] ?? 20,
      idMeal: json['idMeal'],
      strInstructions: json['strInstructions'],
      ingredients: ingredients,
    );
  }

  List<String> getIngredientsAndMeasurements() {
    List<String> combined = [];
    List<String?> ingredients = [
      strIngredient1, strIngredient2,
      strIngredient3, // ... up to strIngredient20
    ];
    List<String?> measurements = [
      strMeasure1, strMeasure2, strMeasure3, // ... up to strMeasure20
    ];

    for (int i = 0; i < ingredients.length; i++) {
      if (ingredients[i] != null && ingredients[i]!.isNotEmpty) {
        String ingredient = ingredients[i]!;
        String measure = measurements[i] ?? "";
        combined.add("$ingredient: $measure");
      }
    }

    return combined;
  }
}

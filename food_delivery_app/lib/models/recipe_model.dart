class Recipe {
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
  String id;
  String title;
  int? readyInMinutes;
  String image;
  String? imageType;
  String? instructions;
  List<AnalyzedInstruction>? analyzedInstructions;
  List<ExtendedIngredients>? extendedIngredients;
  bool isMarkedFavourite;

  Recipe({
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
    required this.id,
    required this.title,
    this.readyInMinutes,
    required this.image,
    this.imageType,
    this.instructions,
    this.analyzedInstructions,
    this.extendedIngredients,
    this.isMarkedFavourite = false,
  });

  factory Recipe.fromJson(
    Map json, {
    bool isMarkedFavourite = false,
  }) {
    if (json.keys.length <= 5) {
      Recipe recipe = Recipe(
        id: json['id'].toString(),
        title: json['title'],
        image: json['image'],
      );
      return recipe;
    }

    List<AnalyzedInstruction> tempAnalyzedInstructions = [];

    if (json['analyzedInstructions'] != null) {
      for (var dataJson in json['analyzedInstructions']) {
        tempAnalyzedInstructions.add(AnalyzedInstruction.fromJson(dataJson));
      }
    }

    List<ExtendedIngredients> tempExtendedIngredients = [];

    if (json['extendedIngredients'] != null) {
      for (var dataJson in json['extendedIngredients']) {
        print(dataJson);
        tempExtendedIngredients.add(ExtendedIngredients.fromJson(dataJson));
      }
    }

    return Recipe(
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
      id: json['id'].toString(),
      title: json['title'],
      readyInMinutes: json['readyInMinutes'],
      image: json['image'],
      imageType: json['imageType'],
      instructions: json['instructions'],
      analyzedInstructions: tempAnalyzedInstructions,
      extendedIngredients: tempExtendedIngredients,
      isMarkedFavourite: isMarkedFavourite,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> tempAnalyzedInstructions = [];
    if (analyzedInstructions != null) {
      for (AnalyzedInstruction analyzedInstruction in analyzedInstructions!) {
        tempAnalyzedInstructions.add(analyzedInstruction.toJson());
      }
    }
    List<Map> tempExtendedIngredients = [];
    if (extendedIngredients != null) {
      for (ExtendedIngredients ingredient in extendedIngredients!) {
        tempExtendedIngredients.add(ingredient.toJson());
      }
    }

    return {
      'vegetarian': vegetarian,
      'vegan': vegan,
      'glutenFree': glutenFree,
      'dairyFree': dairyFree,
      'veryHealthy': veryHealthy,
      'cheap': cheap,
      'veryPopular': veryPopular,
      'sustainable': sustainable,
      'lowFodmap': lowFodmap,
      'weightWatcherSmartPoints': weightWatcherSmartPoints,
      'id': id,
      'title': title,
      'readyInMinutes': readyInMinutes,
      'image': image,
      'imageType': imageType,
      'instructions': instructions,
      'analyzedInstructions': tempAnalyzedInstructions,
      'extendedIngredients': tempExtendedIngredients,
    };
  }
}

class AnalyzedInstruction {
  String name;
  List<StepModel> steps;

  AnalyzedInstruction({
    required this.name,
    required this.steps,
  });

  factory AnalyzedInstruction.fromJson(Map json) {
    return AnalyzedInstruction(
      name: json['name'],
      steps:
          List<StepModel>.from(json['steps'].map((x) => StepModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'steps': List<dynamic>.from(steps.map((x) => x.toJson())),
    };
  }
}

class StepModel {
  int? number;
  String? step;

  StepModel({
    required this.number,
    required this.step,
  });

  factory StepModel.fromJson(Map json) {
    return StepModel(
      number: json['number'],
      step: json['step'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'step': step,
    };
  }
}

class ExtendedIngredients {
  final String name;
  final String amount;
  final String unit;
  final String id;

  const ExtendedIngredients({
    required this.amount,
    required this.id,
    required this.name,
    required this.unit,
  });

  factory ExtendedIngredients.fromJson(Map json) {
    return ExtendedIngredients(
      amount: json['amount'].toString(),
      id: json['id'].toString(),
      name: json['name'].toString(),
      unit: json['unit'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "id": id,
      "name": name,
      "unit": unit,
    };
  }
}

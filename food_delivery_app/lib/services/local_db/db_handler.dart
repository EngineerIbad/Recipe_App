import 'package:food_delivery_app/keys/local_db_keys.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class DBHandler {
  String? filePath;

  static initializeDB() async {
    String filePath =
        await getApplicationDocumentsDirectory().then((value) => value.path);
    Hive.init(filePath);
    await Hive.openBox(HiveKeys.dbKey, path: filePath);
  }

  static saveRecipe(Recipe recipe) async {
    Box favouriteRecipesBox = Hive.box(HiveKeys.favouriteRecipesBox);
    await favouriteRecipesBox.add(recipe.toJson());
  }

  static Future<List<Recipe>> getAllRecipes() async {
    List<Recipe> recipes = <Recipe>[];
    Box favouriteRecipesBox = Hive.box(HiveKeys.favouriteRecipesBox);

    if (!favouriteRecipesBox.isOpen) favouriteRecipesBox = await Hive.openBox(HiveKeys.dbKey);

    Map data = favouriteRecipesBox.toMap();
    List keys = data.keys.toList();

    for (dynamic key in keys) {
      recipes.add(Recipe.fromJson(data[key]));
    }

    return recipes;
  }

  
}

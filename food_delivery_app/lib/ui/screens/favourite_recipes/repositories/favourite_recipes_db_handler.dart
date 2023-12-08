
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/services/local_db/db_handler.dart';
import 'package:hive/hive.dart';

class FavouriteRecipesDBHandler {
  Future<List<Recipe>> getAllFavouriteRecipesList() async {
    Box favouriteRecipesBox = await DBHandler.getRecipeBox();
    List<Recipe> recipes = <Recipe>[];

    if (!favouriteRecipesBox.isOpen) {
      favouriteRecipesBox = await DBHandler.openRecipeBox();
    }

    Map data = favouriteRecipesBox.toMap();
    List keys = data.keys.toList();

    for (dynamic key in keys) {
      var jsonParsedData = Recipe.fromJson(data[key], isMarkedFavourite: true);
      recipes.add(jsonParsedData);
    }
    return recipes;
  }

  Future<Recipe> addRecipeToFavourite(Recipe recipe) async {
    Box favouriteRecipesBox = await DBHandler.getRecipeBox();
    List<Recipe> recipes = await getAllFavouriteRecipesList();
    await Future.delayed(const Duration(milliseconds: 100));

    for (int i = 0; i < recipes.length; i++) {
      Recipe favRecipe = recipes[i];
      if (recipe.id == favRecipe.id) {
        return recipe;
      }
    }

    await favouriteRecipesBox.add(recipe.toJson());
    return recipe;
  }

  Future<bool> removeRecipeFromFavourite(Recipe recipe) async {
    Box favouriteRecipesBox = await DBHandler.getRecipeBox();
    List<Recipe> recipes = await getAllFavouriteRecipesList();

    List<int> indexes = [];

    for (int i = 0; i < recipes.length; i++) {
      Recipe favRecipe = recipes[i];
      if (recipe.id == favRecipe.id) {
        indexes.add(i);
      }
    }

    await Future.delayed(const Duration(milliseconds: 100));
    if (indexes.isEmpty) {
      return false;
    } else {
      for (int index in indexes) {
        await favouriteRecipesBox.deleteAt(index);
      }
      return true;
    }
  }

  Future<bool> isRecipeMarkedFavourite(Recipe recipe) async {
    List<Recipe> recipes = await getAllFavouriteRecipesList();

    for (int i = 0; i < recipes.length; i++) {
      Recipe favRecipe = recipes[i];
      if (recipe.id == favRecipe.id) {
        return true;
      }
    }

    return false;
  }
}

import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/shared/app_urls.dart';
import 'package:food_delivery_app/services/network/network_api_servies.dart';
import 'package:food_delivery_app/ui/screens/favourite_recipes/repositories/favourite_recipes_db_handler.dart';

class GetRecipeRepo {
  Future<List<Recipe>?> getPopularRecipies(int offset) async {
    return await _getRecipesWithDiet("veryPopular", offset);
  }

  Future<List<Recipe>?> getRecipesForHomePage(int offset) async {
    return await _getRecipesWithDiet("veryPopular", offset, number: 20);
  }

  Future<List<Recipe>?> getCheapRecipies(int offset) async {
    return await _getRecipesWithDiet("cheap", offset);
  }

  Future<List<Recipe>?> getVegRecipies(int offset) async {
    return await _getRecipesWithDiet("vegetarian", offset);
  }

  Future<List<Recipe>?> getVeganRecipies(int offset) async {
    return await _getRecipesWithDiet("vegan", offset);
  }

  Future<List<Recipe>?> getDairyFreeRecipies(int offset) async {
    return await _getRecipesWithDiet("dairyFree", offset);
  }

  Future<List<Recipe>?> _getRecipesWithDiet(
    String diet,
    int offset, {
    int number = 25,
  }) async {
    List<Recipe>? recipes;

    final BaseApiServices apiServices = NetworkApiService();
    Map<String, dynamic> response = await apiServices.getCall(
      AppUrls.searchRecipies,
      headers: {"Content-Type": "application/json"},
      params: {
        "diet": "veryPopular",
        "number": number,
        "offset": offset,
        "limitLicense": "true",
      },
    );

    if (response.containsKey('code') && response['code'] != 401) {
      return null;
    } else {
      recipes = [];
      FavouriteRecipesDBHandler handler = FavouriteRecipesDBHandler();

      for (Map<String, dynamic> data in response['results']) {
        Recipe recipe = Recipe.fromJson(data);

        bool isRecipeMarkedFav = await handler.isRecipeMarkedFavourite(recipe);

        recipe.isMarkedFavourite = isRecipeMarkedFav;
        recipes.add(recipe);
      }
    }
    return recipes;
  }
}

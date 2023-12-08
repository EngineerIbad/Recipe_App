import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/shared/app_urls.dart';
import 'package:food_delivery_app/services/network/network_api_servies.dart';
import 'package:food_delivery_app/shared/bloc_instances.dart';
import 'package:food_delivery_app/ui/screens/favourite_recipes/repositories/favourite_recipes_db_handler.dart';

class SearchRecipeRepo {
  Future<List<Recipe>?> getRecipesWithDiet(
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

  Future<List<Recipe>?> searchData(Map<String, dynamic> params) async {
    List<Recipe>? recipes;

    final BaseApiServices apiServices = NetworkApiService();
    Map<String, dynamic> response = await apiServices.getCall(
      AppUrls.searchRecipies,
      headers: {"Content-Type": "application/json"},
      params: {
        ...params,
        "number": 125,
        "offset": BlocInstances.searchRecipesList.length,
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

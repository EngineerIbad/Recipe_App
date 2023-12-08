import 'package:food_delivery_app/bloc/favourite_recipe_bloc/favourite_recipe_bloc.dart';
import 'package:food_delivery_app/bloc/get_recipes_bloc/get_recipes_bloc.dart';
import 'package:food_delivery_app/bloc/internet_bloc/internet_bloc.dart';
import 'package:food_delivery_app/bloc/search_recipe_bloc/search_recipe_bloc.dart';
import 'package:food_delivery_app/models/recipe_model.dart';

class BlocInstances {
  static FavouriteRecipeBloc favouriteRecipeBloc = FavouriteRecipeBloc();
  static GetRecipeBloc getRecipeBloc = GetRecipeBloc();
  static InternetBloc internetBloc = InternetBloc();
  static GetFilterRecipeBloc filteredRecipeBloc = GetFilterRecipeBloc();
  static RecipeDetailsBloc recipeDetailsBloc = RecipeDetailsBloc();
  static SearchRecipeBloc searchRecipeBloc = SearchRecipeBloc();

  static List<Recipe> dietRecipies = [];
  static List<Recipe> homeRecipies = [];
  static List<Recipe> searchRecipesList = [];
  static Recipe? recipe;

  
}

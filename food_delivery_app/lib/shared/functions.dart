import 'package:food_delivery_app/bloc/get_recipes_bloc/get_recipes_bloc.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/shared/bloc_instances.dart';

Future<void> addRecipeToFavourites(Recipe recipe) async {
  BlocInstances.recipeDetailsBloc.add(GetRecipeDetailsInitialEvent(recipe: recipe));
}

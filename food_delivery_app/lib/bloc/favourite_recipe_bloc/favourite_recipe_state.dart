part of 'favourite_recipe_bloc.dart';

abstract class FavouriteRecipeState {}

class InitialFavouriteRecipeState extends FavouriteRecipeState {}

// Add A Recipe To Favourite Recipes
class RecipeAddedToFavouriteState extends FavouriteRecipeState {}

class AddRecipeToFavouriteLoadingState extends FavouriteRecipeState {}

class AddRecipeToFavouriteSuccessState extends FavouriteRecipeState {}

class AddRecipeToFavouriteFaileState extends FavouriteRecipeState {}

// Remove A Recipe From Favourite Recipes
class RecipeRemovedFromFavouriteState extends FavouriteRecipeState {}

class RemoveRecipeFromFavourieLoadingState
    extends RecipeRemovedFromFavouriteState {}

class RemoveRecipeFromFavourieSuccessState
    extends RecipeRemovedFromFavouriteState {
  Recipe recipe;

  RemoveRecipeFromFavourieSuccessState({required this.recipe});
}

class RemoveRecipeFromFavourieFailedState
    extends RecipeRemovedFromFavouriteState {}

// Get All Favourite Recipes From Local DB
class GetAllFavouriteRecipesFromLocalDBInitialState
    extends FavouriteRecipeState {}

class GetAllFavouriteRecipesFromLocalDBSuccessState
    extends FavouriteRecipeState {}

class GetAllFavouriteRecipesFromLocalDBELoadingState
    extends FavouriteRecipeState {}

class GetAllFavouriteRecipesFromLocalDBErrorState
    extends FavouriteRecipeState {}

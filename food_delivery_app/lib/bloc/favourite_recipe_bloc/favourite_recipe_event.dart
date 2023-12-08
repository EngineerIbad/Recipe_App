part of 'favourite_recipe_bloc.dart';

abstract class FavouriteRecipeEvent {}

class InitialFavouriteRecipeEvent extends FavouriteRecipeEvent {}

class AddRecipeToFavouriteEvent extends FavouriteRecipeEvent {
  Recipe recipe;
  AddRecipeToFavouriteEvent({required this.recipe});
}

class RemoveRecipeFromFavouriteEvent extends FavouriteRecipeEvent {
  Recipe recipe;
  RemoveRecipeFromFavouriteEvent({required this.recipe});
}

class GetAllFavouriteRecipesFromLocalDBInitialEvent
    extends FavouriteRecipeEvent {}

class GetAllFavouriteRecipesFromLocalDBSuccessEvent
    extends FavouriteRecipeEvent {}

class GetAllFavouriteRecipesFromLocalDBELoadingvent
    extends FavouriteRecipeEvent {}

class GetAllFavouriteRecipesFromLocalDBErrorEvent
    extends FavouriteRecipeEvent {}

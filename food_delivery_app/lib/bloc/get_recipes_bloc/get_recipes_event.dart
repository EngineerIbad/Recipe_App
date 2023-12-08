part of 'get_recipes_bloc.dart';

abstract class GetRecipesEvents {}

class InitialGetRecipeFetchEvent extends GetRecipesEvents {
  InternetState internetState;
  InitialGetRecipeFetchEvent({required this.internetState});
}

class GetRecipeLoadingEvent extends GetRecipesEvents {}

class GetRecipeErrorEvent extends GetRecipesEvents {}

class GetRecipeSuccessfullyLoadedEvent extends GetRecipesEvents {}

class UnMarkAllFavouritesEvent extends GetRecipesEvents {
  Recipe recipe;
  UnMarkAllFavouritesEvent({required this.recipe});
}

abstract class GetRecipeDetailsEvents {}

class GetRecipeDetailsInitialEvent extends GetRecipeDetailsEvents {
  Recipe recipe;
  GetRecipeDetailsInitialEvent({required this.recipe});
}

abstract class GetFilteredRecipesEvent {}

class GetInitialFilteredRecipesEvent extends GetFilteredRecipesEvent {}

class GetDairyFreeRecipeEvent extends GetFilteredRecipesEvent {
  int offset;
  GetDairyFreeRecipeEvent({required this.offset});
}

class GetVeganRecipeEvent extends GetFilteredRecipesEvent {
  int offset;
  GetVeganRecipeEvent({required this.offset});
}

class GetVegRecipeEvent extends GetFilteredRecipesEvent {
  int offset;
  GetVegRecipeEvent({required this.offset});
}

class GetCheapRecipeEvent extends GetFilteredRecipesEvent {
  int offset;
  GetCheapRecipeEvent({required this.offset});
}

class GetPopularRecipeEvent extends GetFilteredRecipesEvent {
  int offset;
  GetPopularRecipeEvent({required this.offset});
}

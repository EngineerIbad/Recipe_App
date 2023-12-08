part of 'get_recipes_bloc.dart';


abstract class GetRecipesEvents{}

class InitialGetRecipeFetchEvent extends GetRecipesEvents{
  InternetState internetState;
  InitialGetRecipeFetchEvent({required this.internetState});
}
class GetRecipeLoadingEvent extends GetRecipesEvents{}
class GetRecipeErrorEvent extends GetRecipesEvents{}
class GetRecipeSuccessfullyLoadedEvent extends GetRecipesEvents{}


class GetDairyFreeRecipeEvent extends GetRecipesEvents{
  int offset;
  GetDairyFreeRecipeEvent({required this.offset});
}
class GetVeganRecipeEvent extends GetRecipesEvents{
  int offset;
  GetVeganRecipeEvent({required this.offset});
}
class GetVegRecipeEvent extends GetRecipesEvents{
  int offset;
  GetVegRecipeEvent({required this.offset});
}
class GetCheapRecipeEvent extends GetRecipesEvents{
  int offset;
  GetCheapRecipeEvent({required this.offset});
}
class GetPopularRecipeEvent extends GetRecipesEvents{
  int offset;
  GetPopularRecipeEvent({required this.offset});
}

class UnMarkAllFavouritesEvent extends GetRecipesEvents{
  Recipe recipe;
  UnMarkAllFavouritesEvent({required this.recipe});
}


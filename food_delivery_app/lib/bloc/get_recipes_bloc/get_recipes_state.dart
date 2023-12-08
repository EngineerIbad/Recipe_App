part of 'get_recipes_bloc.dart';

abstract class GetRecipesState {}

class InitialGetRecipeFetchState extends GetRecipesState {}

class GetHomePageRecipeLoadingState extends GetRecipesState {}

class GetHomePageRecipeErrorState extends GetRecipesState {}

class GetHomePageRecipeSuccessfullyLoadedState extends GetRecipesState {}

class UnMarkAllFavouritesSuccessState extends GetRecipesState {}

abstract class GetFilteredRecipesState {}

class GetFilterRecipeInitialState extends GetFilteredRecipesState {}

class GetFilterRecipeLoadingState extends GetFilteredRecipesState {}

class GetFilterRecipeErrorState extends GetFilteredRecipesState {}

class GetFilterRecipeSuccessState extends GetFilteredRecipesState {}

abstract class GetRecipeDetailsState {}

class GetRecipeDetailsInitialState extends GetRecipeDetailsState {}

class GetRecipeDetailsLoadingState extends GetRecipeDetailsState {}

class GetRecipeDetailsSuccessState extends GetRecipeDetailsState {}

class GetRecipeDetailsErrorState extends GetRecipeDetailsState {}

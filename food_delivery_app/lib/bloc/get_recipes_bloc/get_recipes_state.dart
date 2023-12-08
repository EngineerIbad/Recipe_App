part of 'get_recipes_bloc.dart';

abstract class GetRecipesState {}

class InitialGetRecipeFetchState extends GetRecipesState {}

class GetRecipeLoadingState extends GetRecipesState {}

class GetRecipeErrorState extends GetRecipesState {}

class GetRecipeSuccessfullyLoadedState extends GetRecipesState {}

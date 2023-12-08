part of 'search_recipe_bloc.dart';

abstract class SearchRecipeState{}

class SearchRecipeInitialState extends SearchRecipeState{}
class SearchRecipeLoadingState extends SearchRecipeState{}
class SearchRecipeSuccessState extends SearchRecipeState{}
class SearchRecipeFailState extends SearchRecipeState{}


class SearchRecipeClearListSuccessState extends SearchRecipeState{}
class SearchRecipeClearListFailState extends SearchRecipeState{}
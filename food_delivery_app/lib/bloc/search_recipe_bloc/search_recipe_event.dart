part of 'search_recipe_bloc.dart';


abstract class SearchRecipeEvent{}

class SearchRecipeInitialEvent extends SearchRecipeEvent{
  Map<String,dynamic> params;
  SearchRecipeInitialEvent({required this.params});
}
class SearchRecipeClearListEvent extends SearchRecipeEvent{}
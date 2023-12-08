import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/shared/bloc_instances.dart';
import 'package:food_delivery_app/ui/screens/search_recipe/repository/search_repo.dart';

part 'search_recipe_event.dart';
part 'search_recipe_state.dart';

class SearchRecipeBloc extends Bloc<SearchRecipeEvent, SearchRecipeState> {
  SearchRecipeBloc() : super(SearchRecipeInitialState()) {
    on<SearchRecipeInitialEvent>(searchRecipeInitialEvent);

    on<SearchRecipeClearListEvent>(searchRecipeClearListEvent);
  }
  SearchRecipeRepo searchRecipeRepo = SearchRecipeRepo();

  FutureOr<void> searchRecipeInitialEvent(
    SearchRecipeInitialEvent event,
    Emitter<SearchRecipeState> emit,
  ) async {
    emit(SearchRecipeLoadingState());

    List<Recipe>? response = await searchRecipeRepo.searchData(event.params);

    if (response == null) {
      emit(SearchRecipeClearListFailState());
    } else {
      BlocInstances.searchRecipesList = response;
      emit(SearchRecipeSuccessState());
    }
  }

  FutureOr<void> searchRecipeClearListEvent(
    SearchRecipeClearListEvent event,
    Emitter<SearchRecipeState> emit,
  ) {
    BlocInstances.searchRecipesList.clear();
    emit(SearchRecipeClearListSuccessState());
  }
}

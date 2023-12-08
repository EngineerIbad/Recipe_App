import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_delivery_app/bloc/internet_bloc/internet_bloc.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/ui/screens/home/repositories/get_recipe_repository.dart';

part 'get_recipes_event.dart';
part 'get_recipes_state.dart';

class GetRecipeBloc extends Bloc<GetRecipesEvents, GetRecipesState> {
  final GetRecipeRepo _repo = GetRecipeRepo();

  GetRecipeBloc() : super(InitialGetRecipeFetchState()) {
    on<InitialGetRecipeFetchEvent>(initialGetRecipeFetchEvent);
    on<GetRecipeLoadingEvent>(getRecipeLoadingEvent);
    on<GetRecipeErrorEvent>(getRecipeErrorEvent);
    on<GetRecipeSuccessfullyLoadedEvent>(getRecipeSuccessfullyLoadedEvent);

    // States for different Diets
    on<GetPopularRecipeEvent>(getPopularRecipeEvent);
    on<GetCheapRecipeEvent>(getCheapRecipeEvent);
    on<GetDairyFreeRecipeEvent>(getDairyFreeRecipeEvent);
    on<GetVegRecipeEvent>(getVegRecipeEvent);
    on<GetVeganRecipeEvent>(getVeganRecipeEvent);

    // Unmark all recipes that were previously added to favourites
    on<UnMarkAllFavouritesEvent>(unMarkAllFavouritesEvent);
  }

  List<Recipe> homeRecipies = [];
  List<Recipe> dietRecipies = [];

  FutureOr<void> initialGetRecipeFetchEvent(
    InitialGetRecipeFetchEvent event,
    Emitter<GetRecipesState> emit,
  ) async {
    homeRecipies.clear();

    emit(GetRecipeLoadingState());

    List<Recipe>? response = await _repo.getRecipesForHomePage(0);

    if (response == null) {
      emit(GetRecipeErrorState());
    } else {
      homeRecipies = response;
      emit(GetRecipeSuccessfullyLoadedState());
    }
  }

  FutureOr<void> getRecipeLoadingEvent(
      GetRecipeLoadingEvent event, Emitter<GetRecipesState> emit) {
    emit(GetRecipeLoadingState());
  }

  FutureOr<void> getRecipeErrorEvent(
      GetRecipeErrorEvent event, Emitter<GetRecipesState> emit) {
    emit(GetRecipeErrorState());
  }

  FutureOr<void> getRecipeSuccessfullyLoadedEvent(
      GetRecipeSuccessfullyLoadedEvent event, Emitter<GetRecipesState> emit) {
    emit(GetRecipeSuccessfullyLoadedState());
  }

  FutureOr<void> getPopularRecipeEvent(
      GetPopularRecipeEvent event, Emitter<GetRecipesState> emit) async {
    dietRecipies.clear();

    emit(GetRecipeLoadingState());

    List<Recipe>? response = await _repo.getPopularRecipies(event.offset);

    if (response == null) {
      emit(GetRecipeErrorState());
    } else {
      dietRecipies = response;
      emit(GetRecipeSuccessfullyLoadedState());
    }
  }

  FutureOr<void> getCheapRecipeEvent(
      GetCheapRecipeEvent event, Emitter<GetRecipesState> emit) async {
    dietRecipies.clear();

    emit(GetRecipeLoadingState());

    List<Recipe>? response = await _repo.getPopularRecipies(event.offset);

    if (response == null) {
      emit(GetRecipeErrorState());
    } else {
      dietRecipies = response;
      emit(GetRecipeSuccessfullyLoadedState());
    }
  }

  FutureOr<void> getDairyFreeRecipeEvent(
      GetDairyFreeRecipeEvent event, Emitter<GetRecipesState> emit) async {}

  FutureOr<void> getVegRecipeEvent(
      GetVegRecipeEvent event, Emitter<GetRecipesState> emit) async {}

  FutureOr<void> getVeganRecipeEvent(
      GetVeganRecipeEvent event, Emitter<GetRecipesState> emit) async {}

  FutureOr<void> unMarkAllFavouritesEvent(
    UnMarkAllFavouritesEvent event,
    Emitter<GetRecipesState> emit,
  ) {
    unmarkAllRecipes(homeRecipies);
    unmarkAllRecipes(dietRecipies);
  }

  void unmarkAllRecipes(List<Recipe> recipeList) {

  }
}

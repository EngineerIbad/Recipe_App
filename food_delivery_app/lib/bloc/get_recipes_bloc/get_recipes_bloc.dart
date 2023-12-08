import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_delivery_app/bloc/internet_bloc/internet_bloc.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/shared/bloc_instances.dart';
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

    // Unmark all recipes that were previously added to favourites
    on<UnMarkAllFavouritesEvent>(unMarkAllFavouritesEvent);

  }


  FutureOr<void> initialGetRecipeFetchEvent(
    InitialGetRecipeFetchEvent event,
    Emitter<GetRecipesState> emit,
  ) async {
    BlocInstances.homeRecipies.clear();

    emit(GetHomePageRecipeLoadingState());

    List<Recipe>? response = await _repo.getRecipesForHomePage(0);

    if (response == null) {
      emit(GetHomePageRecipeErrorState());
    } else {
      BlocInstances.homeRecipies = response;
      emit(GetHomePageRecipeSuccessfullyLoadedState());
    }
  }

  FutureOr<void> getRecipeLoadingEvent(
      GetRecipeLoadingEvent event, Emitter<GetRecipesState> emit) {
    emit(GetHomePageRecipeLoadingState());
  }

  FutureOr<void> getRecipeErrorEvent(
      GetRecipeErrorEvent event, Emitter<GetRecipesState> emit) {
    emit(GetHomePageRecipeErrorState());
  }

  FutureOr<void> getRecipeSuccessfullyLoadedEvent(
      GetRecipeSuccessfullyLoadedEvent event, Emitter<GetRecipesState> emit) {
    emit(GetHomePageRecipeSuccessfullyLoadedState());
  }

  FutureOr<void> unMarkAllFavouritesEvent(
    UnMarkAllFavouritesEvent event,
    Emitter<GetRecipesState> emit,
  ) {
    unmarkAllRecipes(event.recipe);
    emit(UnMarkAllFavouritesSuccessState());
  }

  void unmarkAllRecipes(Recipe targetRecipe) {
    for (Recipe recipe in BlocInstances.homeRecipies) {
      if (recipe.id == targetRecipe.id) {
        recipe.isMarkedFavourite = false;
        break;
      }
    }
    for (Recipe recipe in BlocInstances.dietRecipies) {
      if (recipe.id == targetRecipe.id) {
        recipe.isMarkedFavourite = false;
        break;
      }
    }
  }
}

class GetFilterRecipeBloc
    extends Bloc<GetFilteredRecipesEvent, GetFilteredRecipesState> {
  final GetRecipeRepo _repo = GetRecipeRepo();

  GetFilterRecipeBloc() : super(GetFilterRecipeInitialState()) {
    // States for different Diets
    on<GetPopularRecipeEvent>(getPopularRecipeEvent);
    on<GetCheapRecipeEvent>(getCheapRecipeEvent);
    on<GetDairyFreeRecipeEvent>(getDairyFreeRecipeEvent);
    on<GetVegRecipeEvent>(getVegRecipeEvent);
    on<GetVeganRecipeEvent>(getVeganRecipeEvent);
  }

  FutureOr<void> getPopularRecipeEvent(GetPopularRecipeEvent event,
      Emitter<GetFilteredRecipesState> emit) async {
    BlocInstances.dietRecipies.clear();

    emit(GetFilterRecipeErrorState());

    List<Recipe>? response = await _repo.getPopularRecipies(event.offset);

    if (response == null) {
      emit(GetFilterRecipeErrorState());
    } else {
      BlocInstances.dietRecipies = response;
      emit(GetFilterRecipeSuccessState());
    }
  }

  FutureOr<void> getCheapRecipeEvent(
      GetCheapRecipeEvent event, Emitter<GetFilteredRecipesState> emit) async {
    BlocInstances.dietRecipies.clear();

    emit(GetFilterRecipeLoadingState());

    List<Recipe>? response = await _repo.getCheapRecipies(event.offset);

    if (response == null) {
      emit(GetFilterRecipeErrorState());
    } else {
      BlocInstances.dietRecipies = response;
      emit(GetFilterRecipeSuccessState());
    }
  }

  FutureOr<void> getDairyFreeRecipeEvent(GetDairyFreeRecipeEvent event,
      Emitter<GetFilteredRecipesState> emit) async {
    BlocInstances.dietRecipies.clear();

    emit(GetFilterRecipeLoadingState());

    List<Recipe>? response = await _repo.getDairyFreeRecipies(event.offset);

    if (response == null) {
      emit(GetFilterRecipeErrorState());
    } else {
      BlocInstances.dietRecipies = response;
      emit(GetFilterRecipeSuccessState());
    }
  }

  FutureOr<void> getVegRecipeEvent(
      GetVegRecipeEvent event, Emitter<GetFilteredRecipesState> emit) async {
    BlocInstances.dietRecipies.clear();

    emit(GetFilterRecipeLoadingState());

    List<Recipe>? response = await _repo.getVegRecipies(event.offset);

    if (response == null) {
      emit(GetFilterRecipeErrorState());
    } else {
      BlocInstances.dietRecipies = response;
      emit(GetFilterRecipeSuccessState());
    }
  }

  FutureOr<void> getVeganRecipeEvent(
      GetVeganRecipeEvent event, Emitter<GetFilteredRecipesState> emit) async {
    BlocInstances.dietRecipies.clear();

    emit(GetFilterRecipeLoadingState());

    List<Recipe>? response = await _repo.getVeganRecipies(event.offset);

    if (response == null) {
      emit(GetFilterRecipeErrorState());
    } else {
      BlocInstances.dietRecipies = response;
      emit(GetFilterRecipeSuccessState());
    }
  }
}

class RecipeDetailsBloc
    extends Bloc<GetRecipeDetailsEvents, GetRecipeDetailsState> {
      final GetRecipeRepo _repo = GetRecipeRepo();
  RecipeDetailsBloc() : super(GetRecipeDetailsInitialState()) {
    on<GetRecipeDetailsInitialEvent>(getRecipeDetailsInitialEvent);
  }

  FutureOr<void> getRecipeDetailsInitialEvent(
    GetRecipeDetailsInitialEvent event,
    Emitter<GetRecipeDetailsState> emit,
  ) async {

    emit(GetRecipeDetailsLoadingState());

    Recipe? recipe =  await _repo.getRecipeDetails(event.recipe.id);


    BlocInstances.recipe = recipe;

    emit(GetRecipeDetailsSuccessState());
  }
}

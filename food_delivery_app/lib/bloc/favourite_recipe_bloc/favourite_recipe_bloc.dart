import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/ui/screens/favourite_recipes/repositories/favourite_recipes_db_handler.dart';

part 'favourite_recipe_event.dart';
part 'favourite_recipe_state.dart';

class FavouriteRecipeBloc
    extends Bloc<FavouriteRecipeEvent, FavouriteRecipeState> {
  FavouriteRecipeBloc() : super(InitialFavouriteRecipeState()) {
    on<InitialFavouriteRecipeEvent>(initialFavouriteRecipeEvent);

    on<AddRecipeToFavouriteEvent>(markRecipeAsFavouriteEvent);
    on<RemoveRecipeFromFavouriteEvent>(removeRecipeFromFavouriteEvent);
    on<GetAllFavouriteRecipesFromLocalDBInitialEvent>(
        getAllFavouriteRecipesFromLocalDBInitialEvent);
  }

  FavouriteRecipesDBHandler favouriteRecipesDBHandler =
      FavouriteRecipesDBHandler();
  List<Recipe> favouriteRecipesList = <Recipe>[];

  FutureOr<void> getAllFavouriteRecipesFromLocalDBInitialEvent(
    GetAllFavouriteRecipesFromLocalDBInitialEvent event,
    Emitter<FavouriteRecipeState> emit,
  ) async {
    favouriteRecipesList.clear();

    emit(GetAllFavouriteRecipesFromLocalDBELoadingState());
    await Future.delayed(const Duration(milliseconds: 400));

    favouriteRecipesList =
        await favouriteRecipesDBHandler.getAllFavouriteRecipesList();

    emit(GetAllFavouriteRecipesFromLocalDBSuccessState());
  }

  FutureOr<void> initialFavouriteRecipeEvent(
    InitialFavouriteRecipeEvent event,
    Emitter<FavouriteRecipeState> emit,
  ) {
    emit(InitialFavouriteRecipeState());
  }

  FutureOr<void> markRecipeAsFavouriteEvent(
    AddRecipeToFavouriteEvent event,
    Emitter<FavouriteRecipeState> emit,
  ) async {
    emit(AddRecipeToFavouriteLoadingState());
    await favouriteRecipesDBHandler.addRecipeToFavourite(event.recipe);

    event.recipe.isMarkedFavourite = true;
    favouriteRecipesList.add(event.recipe);

    emit(AddRecipeToFavouriteSuccessState());
  }

  FutureOr<void> removeRecipeFromFavouriteEvent(
    RemoveRecipeFromFavouriteEvent event,
    Emitter<FavouriteRecipeState> emit,
  ) async {
    emit(RemoveRecipeFromFavourieLoadingState());
    await Future.delayed(const Duration(milliseconds: 400));

    bool isDeleted =
        await favouriteRecipesDBHandler.removeRecipeFromFavourite(event.recipe);

    if (isDeleted) {
      favouriteRecipesList.remove(event.recipe);
      emit(RemoveRecipeFromFavourieSuccessState(recipe: event.recipe));
    } else {
      emit(RemoveRecipeFromFavourieFailedState());
    }
  }
}

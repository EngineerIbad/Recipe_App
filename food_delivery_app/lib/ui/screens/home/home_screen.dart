// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/bloc/favourite_recipe_bloc/favourite_recipe_bloc.dart';
import 'package:food_delivery_app/bloc/get_recipes_bloc/get_recipes_bloc.dart';
import 'package:food_delivery_app/bloc/internet_bloc/internet_bloc.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/shared/bloc_instances.dart';
import 'package:food_delivery_app/shared/colors.dart';
import 'package:food_delivery_app/shared/custom_text_styles.dart';
import 'package:food_delivery_app/shared/extensions/padding.dart';
import 'package:food_delivery_app/shared/extensions/text_style_extension.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';
import 'package:food_delivery_app/ui/screens/home/components/categories_slider.dart';
import 'package:food_delivery_app/ui/screens/home/components/custom_favourite_icon_button.dart';
import 'package:food_delivery_app/ui/screens/home/components/custom_search_button.dart';
import 'package:food_delivery_app/ui/screens/home/components/recipe_grid_widget.dart';
import 'package:food_delivery_app/ui/shared_components/custom_loader.dart';
import 'package:food_delivery_app/ui/shared_components/no_data_widget.dart';
import 'package:food_delivery_app/ui/shared_components/no_internet_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  getRecipes() async {
    BlocInstances.getRecipeBloc.add(
      InitialGetRecipeFetchEvent(
        internetState: BlocInstances.internetBloc.state,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<InternetBloc, InternetState>(
          bloc: BlocInstances.internetBloc,
          listener: (context, internetState) {
            if (internetState is InternetGainedState) {
              BlocInstances.getRecipeBloc.add(
                  InitialGetRecipeFetchEvent(internetState: internetState));
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Connected")));
            } else if (internetState is InternetLostState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Disconnected")));
            }
          },
          builder: (context, internetState) =>
              BlocConsumer<FavouriteRecipeBloc, FavouriteRecipeState>(
            bloc: BlocInstances.favouriteRecipeBloc,
            listener: (context, favRecipeState) {
              if (favRecipeState is AddRecipeToFavouriteLoadingState) {
                CustomLoader.showLoaderDialog(context);
              } else if (favRecipeState is AddRecipeToFavouriteFaileState ||
                  favRecipeState is AddRecipeToFavouriteSuccessState) {
                CustomLoader.dispose(context);
              }
            },
            builder: (context, favRecipeState) =>
                BlocConsumer<RecipeDetailsBloc, GetRecipeDetailsState>(
              bloc: BlocInstances.recipeDetailsBloc,
              listener: (context, detailsState) async {
                if (detailsState is GetRecipeDetailsLoadingState) {
                  CustomLoader.showLoaderDialog(context);
                } else if (detailsState is GetRecipeDetailsSuccessState) {
                  await CustomLoader.dispose(context);
                  await Navigator.pushNamed(
                      context, RoutesName.recipeDetailsScreen);
                } else if (detailsState is GetRecipeDetailsErrorState) {
                  CustomLoader.dispose(context);
                }
              },
              builder: (context, detailsState) =>
                  BlocConsumer<GetRecipeBloc, GetRecipesState>(
                bloc: BlocInstances.getRecipeBloc,
                listener: (context, recipeState) {
                  if (recipeState is UnMarkAllFavouritesSuccessState ||
                      favRecipeState is AddRecipeToFavouriteSuccessState ||
                      favRecipeState is RemoveRecipeFromFavourieSuccessState) {
                    setState(() {});
                    BlocInstances.getRecipeBloc
                        .add(GetRecipeSuccessfullyLoadedEvent());
                  }
                },
                builder: (context, recipeState) {
                  if (internetState is InternetGainedState) {
                    if (recipeState is GetHomePageRecipeLoadingState) {
                      return CustomLoader.loader(context);
                    } else if (recipeState
                        is GetHomePageRecipeSuccessfullyLoadedState) {
                      return _homeScreenUi(
                        bloc: BlocInstances.getRecipeBloc,
                        recipes: BlocInstances.homeRecipies,
                        favRecipeBloc: BlocInstances.favouriteRecipeBloc,
                      );
                    } else {
                      return const NoDataWidget(message: "Daily Limit Reached");
                    }
                  } else {
                    return const NoInternetWidget();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onRecipeCategoryTapped(int index, GetFilterRecipeBloc bloc) {
    switch (index) {
      case 0: // Veg
        bloc.add(GetVegRecipeEvent(offset: 20));
        break;
      case 1: // Vegan
        bloc.add(GetVeganRecipeEvent(offset: 20));
        break;
      case 2: // Dairy Free
        bloc.add(GetDairyFreeRecipeEvent(offset: 20));
        break;
      case 3: // Cheap
        bloc.add(GetCheapRecipeEvent(offset: 20));
        break;
    }
    Navigator.pushNamed(context, RoutesName.allRecipesScreen);
  }

  Widget _homeScreenUi({
    required GetRecipeBloc bloc,
    required List<Recipe> recipes,
    required FavouriteRecipeBloc favRecipeBloc,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: 16.paddingLeft(context).copyWith(
                top: 12.pxV(context),
                right: 12.pxV(context),
                bottom: 12.pxH(context),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Welcome!", style: AppTypography.mainHeading(context)),
              const Row(
                children: [
                  SearchIconButton(),
                  FavouritesIconButton(),
                ],
              ),
            ],
          ),
        ),
        CategoriesSlider(
          onTapOfCategory: (ind) =>
              onRecipeCategoryTapped(ind, BlocInstances.filteredRecipeBloc),
        ),
        Padding(
          padding: 16.paddingV(context).copyWith(left: 16.pxH(context)),
          child: Text("Popular Recipes",
              style: AppTypography.mainHeading(context)),
        ),
        if (recipes.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                "No Favourite Recipes Found...",
                style: 16.txt(
                  context,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black700,
                ),
              ),
            ),
          ),
        if (recipes.isNotEmpty)
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: 8.paddingH(context),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.pxH(context),
                crossAxisSpacing: 8.pxV(context),
                mainAxisExtent: 28.percentHeight(context),
              ),
              itemCount: recipes.length,
              itemBuilder: (context, index) => RecipeTile(
                recipe: recipes[index],
                addRecipeToFavourite: (recipe) async {
                  if (recipe.isMarkedFavourite) {
                    favRecipeBloc
                        .add(RemoveRecipeFromFavouriteEvent(recipe: recipe));
                  } else {
                    BlocInstances.favouriteRecipeBloc.add(
                      AddRecipeToFavouriteEvent(recipe: recipe),
                    );
                  }
                },
                onTap: (recipe) {
                  BlocInstances.recipeDetailsBloc
                      .add(GetRecipeDetailsInitialEvent(recipe: recipe));
                },
              ),
            ),
          ),
      ],
    );
  }
}

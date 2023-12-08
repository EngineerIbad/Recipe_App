// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/bloc/favourite_recipe_bloc/favourite_recipe_bloc.dart';
import 'package:food_delivery_app/bloc/get_recipes_bloc/get_recipes_bloc.dart';
import 'package:food_delivery_app/shared/bloc_instances.dart';
import 'package:food_delivery_app/shared/colors.dart';
import 'package:food_delivery_app/shared/custom_text_styles.dart';
import 'package:food_delivery_app/shared/extensions/padding.dart';
import 'package:food_delivery_app/shared/extensions/sized_box.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';
import 'package:food_delivery_app/ui/screens/favourite_recipes/components/favourite_recipe_widget.dart';
import 'package:food_delivery_app/ui/screens/search_recipe/components/custom_back_button.dart';
import 'package:food_delivery_app/ui/shared_components/custom_loader.dart';
import 'package:food_delivery_app/ui/shared_components/no_data_widget.dart';

class AllRecipesScreen extends StatelessWidget {
  const AllRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<RecipeDetailsBloc, GetRecipeDetailsState>(
          bloc: BlocInstances.recipeDetailsBloc,
          listener: (context, recipeDetailsState) {
            if (recipeDetailsState is GetRecipeDetailsLoadingState) {
              CustomLoader.showLoaderDialog(context);
            } else if (recipeDetailsState is GetRecipeDetailsSuccessState ||
                recipeDetailsState is GetRecipeDetailsErrorState) {
              CustomLoader.dispose(context);
            }
          },
          builder: (context, recipeDetailsBlock) =>
              BlocConsumer<FavouriteRecipeBloc, FavouriteRecipeState>(
            bloc: BlocInstances.favouriteRecipeBloc,
            listener: (context, favRecipeState) {},
            builder: (context, favRecipeState) =>
                BlocConsumer<GetFilterRecipeBloc, GetFilteredRecipesState>(
              bloc: BlocInstances.filteredRecipeBloc,
              listener: (context, filteredRecipeState) {},
              builder: (context, filteredRecipeState) {
                if (filteredRecipeState is GetFilterRecipeLoadingState) {
                  return CustomLoader.loader(context);
                } else if (filteredRecipeState is GetFilterRecipeSuccessState) {
                  return Column(
                    children: [
                      Padding(
                        padding: 8.paddingH(context).copyWith(
                              top: 12.pxV(context),
                              bottom: 12.pxV(context),
                            ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomBackButton(
                              paddingLeft: 0,
                              color: AppColors.black,
                            ),
                            16.hSpace(context),
                            Text(
                              "All Recipes",
                              style: AppTypography.mainHeading(context),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: BlocInstances.dietRecipies.length,
                        itemBuilder: (context, index) => FavouriteRecipeWidget(
                          recipe: BlocInstances.dietRecipies[index],
                          delete: (recipe) async {
                            if (recipe.isMarkedFavourite) {
                              BlocInstances.favouriteRecipeBloc.add(
                                RemoveRecipeFromFavouriteEvent(recipe: recipe),
                              );
                            } else {
                              BlocInstances.favouriteRecipeBloc.add(
                                AddRecipeToFavouriteEvent(recipe: recipe),
                              );
                            }
                          },
                          onTap: (recipe) {
                            BlocInstances.recipeDetailsBloc.add(
                                GetRecipeDetailsInitialEvent(recipe: recipe));
                          },
                        ),
                      )),
                    ],
                  );
                } else {
                  return const NoDataWidget(message: "Nothing to show");
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

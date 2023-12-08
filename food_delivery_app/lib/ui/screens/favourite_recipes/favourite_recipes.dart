import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/bloc/favourite_recipe_bloc/favourite_recipe_bloc.dart';
import 'package:food_delivery_app/bloc/get_recipes_bloc/get_recipes_bloc.dart';
import 'package:food_delivery_app/routes/route_names.dart';
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

class FavouriteRecipesScreen extends StatefulWidget {
  const FavouriteRecipesScreen({
    super.key,
  });

  @override
  State<FavouriteRecipesScreen> createState() => _FavouriteRecipesScreenState();
}

class _FavouriteRecipesScreenState extends State<FavouriteRecipesScreen> {
  TextEditingController? searchController;

  getAllFavouriteRecipesFromLocalDB() async {
    BlocInstances.favouriteRecipeBloc
        .add(GetAllFavouriteRecipesFromLocalDBInitialEvent());
  }

  @override
  void initState() {
    searchController = TextEditingController();
    getAllFavouriteRecipesFromLocalDB();
    super.initState();
  }

  @override
  void dispose() {
    searchController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                    "Favourite Recipes",
                    style: AppTypography.mainHeading(context),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<GetRecipeBloc, GetRecipesState>(
                bloc: BlocInstances.getRecipeBloc,
                builder: (context, getRecipeState) =>
                    BlocConsumer<FavouriteRecipeBloc, FavouriteRecipeState>(
                  bloc: BlocInstances.favouriteRecipeBloc,
                  listener: (context, state) {
                    if (state is RemoveRecipeFromFavourieSuccessState) {
                      BlocInstances.getRecipeBloc
                          .add(UnMarkAllFavouritesEvent(recipe: state.recipe));
                    }
                  },
                  builder: (context, favBlocState) {
                    if (favBlocState
                            is GetAllFavouriteRecipesFromLocalDBELoadingState ||
                        favBlocState is RemoveRecipeFromFavourieLoadingState) {
                      return CustomLoader.loader(context);
                    } else if (favBlocState
                        is GetAllFavouriteRecipesFromLocalDBErrorState) {
                      return const NoDataWidget(
                        message: "Nothing In the Favourites",
                        showButton: false,
                      );
                    } else {
                      if (BlocInstances
                          .favouriteRecipeBloc.favouriteRecipesList.isEmpty) {
                        return const NoDataWidget(
                          message: "Nothing In the Favourites",
                          showButton: false,
                        );
                      }

                      return ListView.builder(
                        itemCount: BlocInstances
                            .favouriteRecipeBloc.favouriteRecipesList.length,
                        itemBuilder: (context, index) => FavouriteRecipeWidget(
                          recipe: BlocInstances
                              .favouriteRecipeBloc.favouriteRecipesList[index],
                          delete: (recipe) =>
                              BlocInstances.favouriteRecipeBloc.add(
                            RemoveRecipeFromFavouriteEvent(recipe: recipe),
                          ),
                          onTap: (recipe) {
                            BlocInstances.recipe = recipe;
                            Navigator.pushNamed(context, RoutesName.recipeDetailsScreen);
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

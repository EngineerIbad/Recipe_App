import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/bloc/favourite_recipe_bloc/favourite_recipe_bloc.dart';
import 'package:food_delivery_app/bloc/get_recipes_bloc/get_recipes_bloc.dart';
import 'package:food_delivery_app/bloc/search_recipe_bloc/search_recipe_bloc.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/shared/bloc_instances.dart';
import 'package:food_delivery_app/shared/extensions/padding.dart';
import 'package:food_delivery_app/shared/extensions/sized_box.dart';
import 'package:food_delivery_app/shared/extensions/string_extensions.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';
import 'package:food_delivery_app/ui/screens/home/components/recipe_grid_widget.dart';
import 'package:food_delivery_app/ui/screens/search_recipe/components/custom_back_button.dart';
import 'package:food_delivery_app/ui/screens/search_recipe/components/custom_searchbar.dart';
import 'package:food_delivery_app/ui/shared_components/custom_loader.dart';
import 'package:food_delivery_app/ui/shared_components/no_data_widget.dart';

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({super.key});

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  TextEditingController? searchController;

  @override
  void initState() {
    searchController = TextEditingController();
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.vSpace(context),
            CustomSearchBar(
              leading: const CustomBackButton(),
              searchController: searchController!,
              onSubmit: (value) {
                BlocInstances.searchRecipeBloc.add(SearchRecipeInitialEvent(
                  params: {"query": value.capitalizeInitials()},
                ));
              },
            ),
            16.vSpace(context),
            Expanded(
              child: BlocConsumer<SearchRecipeBloc, SearchRecipeState>(
                bloc: BlocInstances.searchRecipeBloc,
                listener: (context, searchState) {},
                builder: (context, searchState) {
                  if (searchState is SearchRecipeLoadingState) {
                    return CustomLoader.loader(context);
                  } else if (searchState is SearchRecipeSuccessState) {
                    return _dataGrid(context, BlocInstances.searchRecipesList);
                  } else {
                    return const NoDataWidget(
                      message: "Nothing in the search",
                      showButton: false,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dataGrid(BuildContext context, List<Recipe> searchedRecipes) {
    if (searchedRecipes.isEmpty) {
      return const NoDataWidget(
        message: "Nothing in the search",
        showButton: false,
      );
    }
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: 8.paddingH(context),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.pxH(context),
        crossAxisSpacing: 8.pxV(context),
        mainAxisExtent: 28.percentHeight(context),
      ),
      itemCount: searchedRecipes.length,
      itemBuilder: (context, index) => RecipeTile(
        recipe: searchedRecipes[index],
        addRecipeToFavourite: (recipe) async {
          if (recipe.isMarkedFavourite) {
            BlocInstances.favouriteRecipeBloc
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
    );
  }
}

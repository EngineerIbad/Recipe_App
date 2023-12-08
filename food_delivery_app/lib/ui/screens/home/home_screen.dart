import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/bloc/get_recipes_bloc/get_recipes_bloc.dart';
import 'package:food_delivery_app/bloc/internet_bloc/internet_bloc.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
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
    recipeBloc
        .add(InitialGetRecipeFetchEvent(internetState: internetBloc.state));
  }

  GetRecipeBloc recipeBloc = GetRecipeBloc();
  InternetBloc internetBloc = InternetBloc();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<InternetBloc, InternetState>(
          bloc: internetBloc,
          listener: (context, internetState) {
            if (internetState is InternetGainedState) {
              recipeBloc.add(
                  InitialGetRecipeFetchEvent(internetState: internetState));
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Connected")));
            } else if (internetState is InternetLostState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Disconnected")));
            }
          },
          builder: (context, internetState) =>
              BlocBuilder<GetRecipeBloc, GetRecipesState>(
            bloc: recipeBloc,
            builder: (context, recipeState) {
              if (internetState is InternetGainedState) {
                if (recipeState is GetRecipeLoadingState) {
                  return CustomLoader.loader(context);
                } else if (recipeState is GetRecipeSuccessfullyLoadedState) {
                  return _homeScreenUi(
                    bloc: recipeBloc,
                    recipes: recipeBloc.homeRecipies,
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
    );
  }

  Widget _homeScreenUi({
    required GetRecipeBloc bloc,
    required List<Recipe> recipes,
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
               Row(
                children: [
                  const SearchIconButton(),
                  FavouritesIconButton(bloc: bloc),
                ],
              ),
            ],
          ),
        ),
        CategoriesSlider(bloc: bloc),
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
              ),
            ),
          ),
      ],
    );
  }
}

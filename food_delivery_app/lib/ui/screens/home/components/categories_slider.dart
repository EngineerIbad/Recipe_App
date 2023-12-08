import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/bloc/get_recipes_bloc/get_recipes_bloc.dart';
import 'package:food_delivery_app/models/recipe_category_model.dart';
import 'package:food_delivery_app/shared/image_path.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';
import 'package:food_delivery_app/ui/screens/home/components/recipe_category_widget.dart';
import 'package:food_delivery_app/routes/route_names.dart';

class CategoriesSlider extends StatefulWidget {
  final GetRecipeBloc bloc;
  const CategoriesSlider({
    super.key,
    required this.bloc,
  });

  @override
  State<CategoriesSlider> createState() => _CategoriesSliderState();
}

class _CategoriesSliderState extends State<CategoriesSlider> {
  List<RecipeCategoryModel> carousels = const [
    RecipeCategoryModel(
      imageUrl: ImagePath.vegRecipeImage,
      name: "Veg Recipes",
      description: "Recipes that are based on vegitables",
    ),
    RecipeCategoryModel(
      imageUrl: ImagePath.veganRecipeImage,
      name: "Vegan Rcipes",
      description: "Recipes for vegans.",
    ),
    RecipeCategoryModel(
      imageUrl: ImagePath.dairyRecipeImage,
      name: "Dairy Free Recipes",
      description: "All those recipes that exclude dairy products",
    ),
    RecipeCategoryModel(
      imageUrl: ImagePath.cheapRecipeImage,
      name: "Cheap Recipes",
      description: "Easy to cook food recipes",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: carousels.length,
      itemBuilder: (context, index, nextInd) => RecipeCategoryWidget(
        category: carousels[index],
        onTap: () {
          switch (index) {
            case 0: // Veg
              widget.bloc.add(GetVegRecipeEvent(offset: 20));
              break;
            case 1: // Vegan
              widget.bloc.add(GetVeganRecipeEvent(offset: 20));
              break;
            case 2: // Dairy Free
              widget.bloc.add(GetDairyFreeRecipeEvent(offset: 20));
              break;
            case 3: // Cheap
              widget.bloc.add(GetCheapRecipeEvent(offset: 20));
              break;
          }

          Navigator.pushNamed(context, RoutesName.allRecipesScreen);
        },
      ),
      options: CarouselOptions(
        height: 24.percentHeight(context),
        autoPlay: true,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        enlargeFactor: 0.16,
      ),
    );
  }
}
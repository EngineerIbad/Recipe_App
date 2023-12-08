import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/ui/screens/all_recipe/all_recipe_screens.dart';
import 'package:food_delivery_app/ui/screens/favourite_recipes/favourite_recipes.dart';
import 'package:food_delivery_app/ui/screens/home/home_screen.dart';
import 'package:food_delivery_app/ui/screens/recipe_details/recipe_details_screen.dart';
import 'package:food_delivery_app/ui/screens/search_recipe/search_recipe_screen.dart';
import 'package:food_delivery_app/ui/screens/splash/splash_screen.dart';

import '../bloc/get_recipes_bloc/get_recipes_bloc.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Splash
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      // All Recipes Screen
      case RoutesName.allRecipesScreen:
        return MaterialPageRoute(
            builder: (context) => const AllRecipesScreen());

      // Home Screen
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      // Recipe Details Screen
      case RoutesName.recipeDetailsScreen:
        return MaterialPageRoute(
            builder: (context) => const RecipeDetailsScreen());

      // Search Screen
      case RoutesName.searchScreen:
        return MaterialPageRoute(
            builder: (context) => const SearchRecipeScreen());

      // Favourite Recipe Screen
      case RoutesName.favouriteRecipesScreen:
        GetRecipeBloc bloc = settings.arguments as GetRecipeBloc;
        return MaterialPageRoute(
          builder: (context) => FavouriteRecipesScreen(getRecipeBloc: bloc),
        );

      // No route defined
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No route defined'),
              ),
            );
          },
        );
    }
  }
}

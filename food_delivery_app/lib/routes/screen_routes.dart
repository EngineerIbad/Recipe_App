import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/ui/screens/all_recipe/all_recipe_screens.dart';
import 'package:food_delivery_app/ui/screens/favourite_recipes/favourite_recipes.dart';
import 'package:food_delivery_app/ui/screens/home/home_screen.dart';
import 'package:food_delivery_app/ui/screens/recipe_details/recipe_details_screen.dart';
import 'package:food_delivery_app/ui/screens/search_recipe/search_recipe_screen.dart';
import 'package:food_delivery_app/ui/screens/splash/splash_screen.dart';


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
        return MaterialPageRoute(
          builder: (context) => const FavouriteRecipesScreen(),
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

import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/ui/screens/all_recipe/all_recipe_screens.dart';
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

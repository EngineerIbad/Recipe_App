import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/bloc/favourite_recipe_bloc/favourite_recipe_bloc.dart';
import 'package:food_delivery_app/shared/colors.dart';
import 'package:food_delivery_app/shared/extensions/sized_box.dart';
import 'package:food_delivery_app/shared/extensions/text_style_extension.dart';
import 'package:food_delivery_app/shared/image_path.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';
import 'package:food_delivery_app/routes/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FavouriteRecipeBloc favouriteRecipeBloc = FavouriteRecipeBloc();
  @override
  void initState() {
    getAllFavouriteRecipesFromLocalDB();
    _navigateToNextScreen();
    super.initState();
  }

  getAllFavouriteRecipesFromLocalDB() async {
    favouriteRecipeBloc.add(GetAllFavouriteRecipesFromLocalDBInitialEvent());
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3)).whenComplete(
      () => Navigator.pushReplacementNamed(context, RoutesName.home),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavouriteRecipeBloc, FavouriteRecipeState>(
        bloc: favouriteRecipeBloc,
        builder: (context, state) => _splashUi(),
      ),
    );
  }

  Widget _splashUi() {
    return SizedBox(
      height: 100.percentHeight(context),
      width: 100.percentWidth(context),
      child: Stack(
        children: [
          Container(
            height: 100.percentHeight(context),
            width: 100.percentWidth(context),
            color: AppColors.black,
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                ImagePath.splashImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Welcome",
                  style: 56.txt(context, color: AppColors.white, height: 0),
                ),
                8.vSpace(context),
                SizedBox(
                  width: 100.percentWidth(context),
                  child: Text(
                    "Explore New Recipes and Save for Offline Access",
                    style: 24.txt(
                      context,
                      color: AppColors.white,
                      height: 0,
                    ),
                  ),
                ),
                32.vSpace(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

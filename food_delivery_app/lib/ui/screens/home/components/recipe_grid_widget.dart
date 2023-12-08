import 'package:flutter/material.dart';
import 'package:food_delivery_app/bloc/favourite_recipe_bloc/favourite_recipe_bloc.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/shared/colors.dart';
import 'package:food_delivery_app/shared/extensions/padding.dart';
import 'package:food_delivery_app/shared/extensions/text_style_extension.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  const RecipeTile({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.amber,
        borderRadius: BorderRadius.circular(16.pxH(context)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.pxH(context)),
        child: Stack(
          children: [
            Image.network(
              recipe.imageUrl,
              fit: BoxFit.fill,
              height: 100.percentHeight(context),
              width: 100.percentWidth(context),
            ),
            Container(
              height: 100.percentHeight(context),
              width: 100.percentWidth(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black400,
                    AppColors.black400,
                    AppColors.black600,
                    AppColors.black700,
                    AppColors.black700,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20.pxV(context),
              left: 12.pxH(context),
              width: 42.percentWidth(context),
              child: Text(
                recipe.title,
                style: 20.txt(
                  context,
                  color: AppColors.white,
                  height: 0,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Positioned(
              top: 0.pxV(context),
              right: 0.pxV(context),
              child: GestureDetector( 
                onTap: () {
                  FavouriteRecipeBloc favouriteRecipeBloc = FavouriteRecipeBloc();
                  favouriteRecipeBloc.add(AddRecipeToFavouriteEvent(recipe: recipe));
                },
                child: Padding(
                  padding: 16.paddingTop(context).copyWith(
                        right: 16.pxH(context),
                      ),
                  child: recipe.isMarkedFavourite
                      ? Icon(
                          Icons.favorite_rounded,
                          color: AppColors.amber,
                        )
                      : Icon(
                          Icons.favorite_outline_rounded,
                          color: AppColors.white,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

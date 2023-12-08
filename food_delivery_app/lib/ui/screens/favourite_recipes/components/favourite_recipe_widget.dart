import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/shared/colors.dart';
import 'package:food_delivery_app/shared/extensions/padding.dart';
import 'package:food_delivery_app/shared/extensions/sized_box.dart';
import 'package:food_delivery_app/shared/extensions/text_style_extension.dart';
import 'package:food_delivery_app/shared/image_path.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';

class FavouriteRecipeWidget extends StatelessWidget {
  final Recipe recipe;
  final Function(Recipe) delete;
  final Function(Recipe) onTap;
  const FavouriteRecipeWidget({
    super.key,
    required this.recipe,
    required this.delete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.pxV(context),
      width: 90.percentWidth(context),
      margin: 16.paddingH(context).copyWith(bottom: 16.pxV(context)),
      child: GestureDetector(
        onTap: () {
          onTap(recipe);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.pxH(context)),
              child: Stack(
                children: [
                  Container(color: AppColors.amber),
                  Image.network(
                    recipe.image,
                    fit: BoxFit.cover,
                    height: 100.percentHeight(context),
                    width: 100.percentWidth(context),
                    errorBuilder: (context, obj, stack) => Image.asset(
                      ImagePath.popularRecipeImage,
                      fit: BoxFit.cover,
                      height: 100.percentHeight(context),
                      width: 100.percentWidth(context),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.transparent,
                          AppColors.black400,
                          AppColors.black700,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: 16.paddingLeft(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 75.percentWidth(context),
                        child: Text(
                          recipe.title,
                          style: 24.txt(
                            context,
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          delete(recipe);
                        },
                        child: Padding(
                          padding: 4.paddingH(context).copyWith(
                                top: 4.pxV(context),
                                bottom: 4.pxV(context),
                              ),
                          child: recipe.isMarkedFavourite
                              ? Icon(
                                  Icons.favorite_rounded,
                                  color: AppColors.amber,
                                  size: 32.pxH(context),
                                )
                              : Icon(
                                  Icons.favorite_outline_rounded,
                                  color: AppColors.white,
                                  size: 32.pxH(context),
                                ),
                        ),
                      ),
                    ],
                  ),
                  16.vSpace(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

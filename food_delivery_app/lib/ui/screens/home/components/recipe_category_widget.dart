import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/recipe_category_model.dart';
import 'package:food_delivery_app/shared/colors.dart';
import 'package:food_delivery_app/shared/extensions/padding.dart';
import 'package:food_delivery_app/shared/extensions/sized_box.dart';
import 'package:food_delivery_app/shared/extensions/text_style_extension.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';

class RecipeCategoryWidget extends StatelessWidget {
  final RecipeCategoryModel category;
  final Function() onTap;
  const RecipeCategoryWidget({
    super.key,
    required this.category,
    required this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.percentHeight(context),
        width: 90.percentWidth(context),
        margin: 4.paddingH(context),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.pxH(context)),
              child: Stack(
                children: [
                  Image.asset(
                    category.imageUrl,
                    fit: BoxFit.cover,
                    height: 100.percentHeight(context),
                    width: 100.percentWidth(context),
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
                  Text(
                    category.name,
                    style: 24.txt(context,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        height: 0),
                  ),
                  8.vSpace(context),
                  SizedBox(
                    width: 70.percentWidth(context),
                    child: Text(
                      category.description,
                      style: 16.txt(
                        context,
                        color: AppColors.white,
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                      maxLines: 3,
                    ),
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

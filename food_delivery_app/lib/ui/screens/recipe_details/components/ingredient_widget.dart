import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/shared/colors.dart';
import 'package:food_delivery_app/shared/extensions/padding.dart';
import 'package:food_delivery_app/shared/extensions/sized_box.dart';
import 'package:food_delivery_app/shared/extensions/string_extensions.dart';
import 'package:food_delivery_app/shared/extensions/text_style_extension.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';

class IngredientWidget extends StatelessWidget {
  final ExtendedIngredients ingrediant;
  const IngredientWidget({
    super.key,
    required this.ingrediant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 24.paddingLeft(context).copyWith(
            bottom: 16.pxV(context),
            right: 16.pxH(context),
          ),
      width: 100.percentWidth(context),
      child: Row(
        children: [
          CircleAvatar(
            radius: 4,
            backgroundColor: AppColors.amber,
          ),
          16.hSpace(context),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: 18.txt(
                  context,
                  color: AppColors.black700,
                  height: 0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ingrediant.name.capitalizeInitials(),
                  ),
                  TextSpan(
                    text: "(${ingrediant.amount} ${ingrediant.unit})",
                    style: 18.txt(
                      context,
                      fontWeight: FontWeight.w500,
                      color: AppColors.amber,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/shared/bloc_instances.dart';
import 'package:food_delivery_app/shared/colors.dart';
import 'package:food_delivery_app/shared/custom_text_styles.dart';
import 'package:food_delivery_app/shared/extensions/padding.dart';
import 'package:food_delivery_app/shared/extensions/sized_box.dart';
import 'package:food_delivery_app/shared/extensions/text_style_extension.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';
import 'package:food_delivery_app/ui/screens/recipe_details/components/ingredient_widget.dart';
import 'package:food_delivery_app/ui/screens/recipe_details/components/steps_widget.dart';
import 'package:food_delivery_app/ui/screens/search_recipe/components/custom_back_button.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: 8.paddingH(context).copyWith(
                top: 12.pxV(context),
              ),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomBackButton(
                    paddingLeft: 0,
                    color: AppColors.black,
                  ),
                  16.hSpace(context),
                  Text(
                    "Recipe Details",
                    style: AppTypography.mainHeading(context),
                  ),
                  const Spacer(),
                ],
              ),
              16.vSpace(context),
              Expanded(
                child: ListView(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.pxV(context)),
                      child: Container(
                        color: AppColors.black700,
                        width: 100.percentWidth(context),
                        height: 240.pxV(context),
                        child: Image.network(BlocInstances.recipe!.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, a, b) => const Center(
                                  child: Text("CoverImageHere"),
                                ),
                            loadingBuilder: (context, widget, loadingProgress) {
                              if (loadingProgress != null) {
                                return Container(
                                  height: 240.pxV(context),
                                  width: 100.percentWidth(context),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Loading Cover Image...",
                                  ),
                                );
                              }
                              return widget;
                            }),
                      ),
                    ),
                    8.vSpace(context),
                    Text(
                      BlocInstances.recipe!.title,
                      style: 32.txt(
                        context,
                        color: AppColors.black700,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    24.vSpace(context),
                    Padding(
                      padding: 8.paddingLeft(context),
                      child: Text(
                        "Ingredients",
                        style: 28.txt(
                          context,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    24.vSpace(context),
                    ...BlocInstances.recipe!.extendedIngredients!
                        .map(
                          (ingrediant) =>
                              IngredientWidget(ingrediant: ingrediant),
                        )
                        .toList(),
                    24.vSpace(context),
                    Padding(
                      padding: 8.paddingLeft(context),
                      child: Text(
                        "Steps To Follow",
                        style: 28.txt(
                          context,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    for (AnalyzedInstruction analyzedIns
                        in BlocInstances.recipe!.analyzedInstructions!) ...[
                      Text(analyzedIns.name),
                      ...analyzedIns.steps.map(
                        (step) => StepWidget(step: step),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

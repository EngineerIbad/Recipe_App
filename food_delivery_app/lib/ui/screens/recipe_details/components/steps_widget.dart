import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/recipe_model.dart';
import 'package:food_delivery_app/shared/colors.dart';
import 'package:food_delivery_app/shared/extensions/padding.dart';
import 'package:food_delivery_app/shared/extensions/sized_box.dart';
import 'package:food_delivery_app/shared/extensions/text_style_extension.dart';

class StepWidget extends StatelessWidget {
  final StepModel step;
  const StepWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 24.paddingBottom(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: 4.paddingRight(context),
              child: Text(
                step.number.toString(),
                style: 40.txt(
                  context,
                  fontWeight: FontWeight.w500,
                  color: AppColors.amber,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          16.hSpace(context),
          Container(
            height: 80,
            width: 1.5,
            color: AppColors.amber,
          ),
          16.hSpace(context),
          Expanded(
            flex: 20,
            child: Text(
              step.step!,
              style: 16.txt(
                context,
                color: AppColors.black700,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

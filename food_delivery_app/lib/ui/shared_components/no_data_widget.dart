import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/shared/colors.dart';
import 'package:food_delivery_app/shared/extensions/padding.dart';
import 'package:food_delivery_app/shared/extensions/sized_box.dart';
import 'package:food_delivery_app/shared/extensions/text_style_extension.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  final bool showButton;
  const NoDataWidget({
    super.key,
    required this.message,
    this.showButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.no_accounts,
            size: 88.pxV(context),
            color: AppColors.black500,
          ),
          Text(
            message,
            style: 24.txt(
              context,
              color: AppColors.black700,
            ),
          ),
          if (showButton) ...[
            32.vSpace(context),
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, RoutesName.favouriteRecipesScreen),
              child: Container(
                padding: 16.paddingV(context).copyWith(
                      left: 24.pxH(context),
                      right: 24.pxH(context),
                    ),
                decoration: BoxDecoration(
                    color: AppColors.amber,
                    borderRadius: BorderRadius.circular(16.pxH(context))),
                child: Text(
                  "Go to Favourites",
                  style: 16.txt(
                    context,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

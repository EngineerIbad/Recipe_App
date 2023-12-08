import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';

class SearchIconButton extends StatelessWidget {
  final double paddingLeft, paddingRight, paddingTop, paddingBottom;
  final bool shouldNavigateToSearchScreen;
  final Function()? onButtonTap;
  const SearchIconButton({
    super.key,
    this.paddingLeft = 4,
    this.paddingRight = 4,
    this.paddingBottom = 4,
    this.paddingTop = 4,
    this.shouldNavigateToSearchScreen = true,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onButtonTap != null) onButtonTap!();

        if (shouldNavigateToSearchScreen) {
          Navigator.pushNamed(context, RoutesName.searchScreen);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: paddingTop.pxV(context),
          bottom: paddingBottom.pxV(context),
          left: paddingLeft.pxH(context),
          right: paddingRight.pxH(context),
        ),
        child: Icon(
          Icons.search,
          size: 32.pxH(context),
        ),
      ),
    );
  }
}

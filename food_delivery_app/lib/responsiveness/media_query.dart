import 'package:flutter/material.dart';

extension DynamicHeight on num {
  double pxV(BuildContext context) {
    // Calculating that what was the percentage of the given value in figma
    const double figmaHeight = 844;
    double figmaRatio = (this * 100) / figmaHeight;

    double currentScreenRatio = (MediaQuery.sizeOf(context).height -
            MediaQuery.paddingOf(context).bottom -
            kToolbarHeight) *
        (figmaRatio / 100);

    return currentScreenRatio;
    // return toDouble();
  }

  double pxH(BuildContext context) {
    // Calculating that what was the percentage of the given value in figma
    const double figmaWidth = 390;
    double figmaRatio = (this * 100) / figmaWidth;

    double currentScreenRatio = figmaRatio.percentWidth(context);

    return currentScreenRatio;
    // return toDouble();
  }

  double percentHeight(BuildContext context) {
    return (MediaQuery.sizeOf(context).height) * (this / 100);
  }

  double percentWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * (this / 100);
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery_app/shared/extensions/text_style_extension.dart';

class AppTypography {
  static TextStyle mainHeading(BuildContext context) {
    return 32.txt(
      context,
      fontWeight: FontWeight.w500,
      height: 0,
    );
  }
}

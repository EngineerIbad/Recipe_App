import 'package:flutter/material.dart';
import 'package:food_delivery_app/shared/colors.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';

class CustomBackButton extends StatelessWidget {
  final double paddingLeft, paddingRight, paddingTop, paddingBottom;
  final Function()? onTap;
  final bool shouldPop;
  final Color? color;
  const CustomBackButton({
    super.key,
    this.paddingLeft = 4,
    this.paddingRight = 4,
    this.paddingBottom = 4,
    this.paddingTop = 4,
    this.onTap,
    this.color,
    this.shouldPop = true, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
        if(shouldPop) Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: paddingTop.pxV(context),
          bottom: paddingBottom.pxV(context),
          left: paddingLeft.pxH(context),
          right: paddingRight.pxH(context),
        ),
        child: Icon(
          Icons.arrow_back,
          size: 32.pxH(context),
          color: color ?? AppColors.black500,
        ),
      ),
    );
  }
}

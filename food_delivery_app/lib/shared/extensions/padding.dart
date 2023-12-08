import 'package:flutter/material.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';

extension GlobalPadding on num {
  EdgeInsets paddingH(BuildContext context) {
    return EdgeInsets.symmetric(horizontal: pxH(context));
  }

  EdgeInsets paddingV(BuildContext context) {
    return EdgeInsets.symmetric(vertical: pxV(context));
  }

  EdgeInsets paddingAll(BuildContext context) {
    return EdgeInsets.all(pxV(context));
  }

  EdgeInsets paddingTop(BuildContext context) {
    return EdgeInsets.only(top: pxV(context));
  }

  EdgeInsets paddingBottom(BuildContext context) {
    return EdgeInsets.only(bottom: pxV(context));
  }

  EdgeInsets paddingRight(BuildContext context) {
    return EdgeInsets.only(right: pxV(context));
  }

  EdgeInsets paddingLeft(BuildContext context) {
    return EdgeInsets.only(left: pxV(context));
  }
}

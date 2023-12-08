import 'package:flutter/material.dart';
import 'package:food_delivery_app/shared/colors.dart';

class CustomLoader {
  static showLoaderDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      barrierColor: AppColors.black400,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => true,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.amber,
          ),
        ),
      ),
    );
  }

  static dispose(BuildContext context) {
    Navigator.pop(context);
  }

  static loader(
    BuildContext context, {
    bool isAlreadyExpanded = true,
  }) {
    if (isAlreadyExpanded) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.amber,
        ),
      );
    } else {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.amber,
          ),
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery_app/shared/colors.dart';
import 'package:food_delivery_app/shared/extensions/padding.dart';
import 'package:food_delivery_app/shared/extensions/text_style_extension.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final double? height, width;
  final Widget? leading;
  final Function(String) onSubmit;
  const CustomSearchBar({
    super.key,
    required this.searchController,
    this.height,
    this.width,
    this.leading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SearchBar(
        onSubmitted: onSubmit,
        padding: MaterialStatePropertyAll(
          4.paddingV(context).copyWith(
                left: 16.pxH(context),
                right: 16.pxH(context),
              ),
        ),
        trailing: [
          Icon(
            Icons.search,
            size: 40.pxV(context),
            color: AppColors.black400,
          ),
        ],
        leading: leading,
        constraints: BoxConstraints(
          maxWidth: width ?? 96.percentWidth(context),
          minHeight: height ?? 56.pxV(context),
        ),
        controller: searchController,
        hintText: "Search Recipes",
        hintStyle: MaterialStatePropertyAll(
          24.txt(
            context,
            color: AppColors.black400,
          ),
        ),
        textStyle: MaterialStatePropertyAll(
          24.txt(
            context,
            color: AppColors.black,
          ),
        ),
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: MaterialStatePropertyAll(AppColors.white),
        side: MaterialStatePropertyAll(
          BorderSide(
            width: 1.pxH(context),
            color: AppColors.black500,
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/bloc/get_recipes_bloc/get_recipes_bloc.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/shared/responsiveness/media_query.dart';

class FavouritesIconButton extends StatelessWidget {
  final double paddingLeft, paddingRight, paddingTop, paddingBottom;
  final Future<dynamic> Function()? function;
  final GetRecipeBloc bloc;
  const FavouritesIconButton({
    super.key,
    this.paddingLeft = 4,
    this.paddingRight = 4,
    this.paddingBottom = 4,
    this.paddingTop = 4,
    this.function,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (function != null) {
          await function!();
        }
        Navigator.pushNamed(
          context,
          RoutesName.favouriteRecipesScreen,
          arguments: bloc,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: paddingTop.pxV(context),
          bottom: paddingBottom.pxV(context),
          left: paddingLeft.pxH(context),
          right: paddingRight.pxH(context),
        ),
        child: Icon(
          Icons.favorite_outline_rounded,
          size: 32.pxH(context),
        ),
      ),
    );
  }
}

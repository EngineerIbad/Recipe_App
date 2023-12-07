import 'package:flutter/material.dart';
import 'package:food_delivery_app/extensions/sized_box.dart';
import 'package:food_delivery_app/extensions/text_style_extension.dart';
import 'package:food_delivery_app/keys/image_path.dart';
import 'package:food_delivery_app/responsiveness/media_query.dart';
import 'package:food_delivery_app/routes/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToNextScreen();
    super.initState();
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3)).whenComplete(
      () => Navigator.pushNamed(context, RoutesName.allRecipesScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.percentHeight(context),
        width: 100.percentWidth(context),
        child: Stack(
          children: [
            Container(
              height: 100.percentHeight(context),
              width: 100.percentWidth(context),
              color: Colors.black,
              child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  ImagePath.splashImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome",
                    style: 56.txt(context, color: Colors.white, height: 0),
                  ),
                  8.vSpace(context),
                  SizedBox(
                    width: 100.percentWidth(context),
                    child: Text(
                      "Explore New Recipes and Save for Offline Access",
                      style: 24.txt(
                        context,
                        color: Colors.white,
                        height: 0,
                      ),
                    ),
                  ),
                  32.vSpace(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

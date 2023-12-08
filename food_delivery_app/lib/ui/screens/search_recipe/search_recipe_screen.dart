import 'package:flutter/material.dart';
import 'package:food_delivery_app/shared/extensions/sized_box.dart';
import 'package:food_delivery_app/ui/screens/search_recipe/components/custom_back_button.dart';
import 'package:food_delivery_app/ui/screens/search_recipe/components/custom_searchbar.dart';

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({super.key});

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  TextEditingController? searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.vSpace(context),
            CustomSearchBar(
              leading: const CustomBackButton(),
              searchController: searchController!,
            ),
            16.vSpace(context),
          ],
        ),
      ),
    );
  }
}


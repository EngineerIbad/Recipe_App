import 'dart:convert';

class Recipe {
  final int id;
  final String imageUrl;
  final String title;
  bool isMarkedFavourite;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isMarkedFavourite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "image": imageUrl,
      "is_favourite": isMarkedFavourite,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    bool isMarkedFavourite = false,
  }) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
      isMarkedFavourite: isMarkedFavourite,
    );
  }
}


/**
 
        {
            "id": 782585,
            "title": "Cannellini Bean and Asparagus Salad with Mushrooms",
            "image": "https://spoonacular.com/recipeImages/782585-312x231.jpg",
            "imageType": "jpg"
        },

 */
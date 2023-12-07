import 'dart:convert';

class Recipe {
  final String id;

  const Recipe({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(id: json['id']);
  }
}

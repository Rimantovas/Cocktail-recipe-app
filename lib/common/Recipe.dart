import 'package:flutter/cupertino.dart';

class Recipe {
  final String id;
  final String image;
  final String name;
  final String description;
  final List<String> ingridients;
  final String instructions;
  bool isFavourite;
  Recipe(
      {required this.id,
      required this.image,
      required this.name,
      required this.description,
      required this.ingridients,
      required this.instructions,
      required this.isFavourite});

  Recipe.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        name = json['name'],
        description = json['description'],
        ingridients = List<String>.from(json['ingridients'].map((x) => x)),
        instructions = json['instructions'],
        isFavourite = json['isFavourite'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
        'description': description,
        'ingridients': ingridients,
        'instructions': instructions,
        'isFavourite': isFavourite,
      };
}

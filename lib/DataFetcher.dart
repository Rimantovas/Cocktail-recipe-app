import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipeapp/common/common.dart';
import 'common/Recipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fetcher {
  static Future<RecipesModel> fetchData(String drink) async {
    try {
      RecipesModel list = new RecipesModel();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final String url =
          "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$drink";

      var response = await http.get(Uri.parse(url));

      var result = jsonDecode(response.body);
      for (var recipe in result['drinks']) {
        int i = 1;
        List<String> ingridients = [];
        while (recipe['strIngredient$i'] != null &&
            recipe['strIngredient$i'] != "") {
          String measure = recipe['strMeasure$i'] != null
              ? "${recipe['strMeasure$i'].trim()} "
              : "";
          ingridients.add("$measure${recipe['strIngredient$i']}");
          i++;
        }
        String json = prefs.getString(recipe['idDrink'].toString()) ?? "";

        list.addRecipe(new Recipe(
            isFavourite: json == ""
                ? false
                : Recipe.fromJson(jsonDecode(json)).isFavourite,
            id: recipe['idDrink'].toString(),
            image: recipe['strDrinkThumb'],
            name: recipe['strDrink'],
            description: recipe['strIBA'] != null
                ? recipe['strIBA']
                : recipe['strCategory'],
            ingridients: ingridients,
            instructions: recipe['strInstructions']));
      }

      return list;
    } catch (e) {
      return new RecipesModel();
    }
  }

  static Future<Recipe?> fetchRandom() async {
    try {
      final String url =
          "https://www.thecocktaildb.com/api/json/v1/1/random.php";

      var response = await http.get(Uri.parse(url));
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var result = jsonDecode(response.body);
      for (var recipe in result['drinks']) {
        int i = 1;
        List<String> ingridients = [];
        while (recipe['strIngredient$i'] != null &&
            recipe['strIngredient$i'] != "") {
          String measure = recipe['strMeasure$i'] != null
              ? "${recipe['strMeasure$i'].trim()} "
              : "";
          ingridients.add("$measure${recipe['strIngredient$i']}");
          i++;
        }
        String json = (prefs.getString(recipe['idDrink']) ?? "");
        //Recipe temp = Recipe.fromJson(jsonDecode(json));
        return new Recipe(
            isFavourite: json == "" ? false : true,
            id: recipe['idDrink'],
            image: recipe['strDrinkThumb'],
            name: recipe['strDrink'],
            description: recipe['strIBA'] != null
                ? recipe['strIBA']
                : recipe['strCategory'],
            ingridients: ingridients,
            instructions: recipe['strInstructions']);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<RecipesModel> fetchFavourites() async {
    try {
      RecipesModel list = new RecipesModel();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> keys = prefs.getKeys().toList();
      for (String key in keys) {
        String json = prefs.getString(key) ?? "";
        if (json != "") {
          Recipe item = new Recipe.fromJson(jsonDecode(json));
          if (item.isFavourite) list.addRecipe(item);
        }
      }
      return list;
    } catch (e) {
      return new RecipesModel();
    }
  }
}

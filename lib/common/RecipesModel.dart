import 'package:flutter/cupertino.dart';
import 'package:recipeapp/common/common.dart';

import '../DataFetcher.dart';

class RecipesModel extends ChangeNotifier {
  List<Recipe> recipes = [];

  addRecipe(Recipe recipe) {
    recipes.add(recipe);
    notifyListeners();
  }

  removeRecipe(Recipe recipe) {
    recipes.remove(recipe);
  }

  addFavourite(int index) {
    recipes[index].isFavourite = !recipes[index].isFavourite;
    notifyListeners();
  }

  changeRecipes(RecipesModel newOnes) {
    recipes = newOnes.recipes;
    notifyListeners();
  }

  Future getStartingValues() async {
    var result = await Fetcher.fetchData("Margarita");
    changeRecipes(result);
  }

  Future filterFavourites() async {
    var result = await Fetcher.fetchFavourites();
    changeRecipes(result);
  }
}

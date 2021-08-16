import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/DataFetcher.dart';
import 'package:recipeapp/common/common.dart';
import 'package:recipeapp/screens/screens.dart';
import 'package:recipeapp/styling/styling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  Future<void> createRandom(BuildContext context) async {
    var recipe = await Fetcher.fetchRandom();
    if (recipe != null) {
      Provider.of<RecipesModel>(context, listen: false).addRecipe(recipe);
      int index =
          Provider.of<RecipesModel>(context, listen: false).recipes.length;
      Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DetailsPage(index: index - 1)));
    } else
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error occurred")));
  }

  Future<void> addFavourite(Recipe val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(val.id, json.encode(val.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    final recipeModels = Provider.of<RecipesModel>(context);
    if (recipeModels.recipes.isEmpty) recipeModels.getStartingValues();
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        function: () {
          createRandom(context);
        },
        actionWidget: Consumer<Dropdown>(
          builder: (context, dropdown, child) {
            return CountryDropdown(
              names: dropdown.values,
              name: dropdown.value,
              onChanged: (val) async {
                if (dropdown.value != val) {
                  if (val == "Favourites") {
                    dropdown.changeValue(val ?? "");
                    recipeModels.filterFavourites();
                  } else {
                    dropdown.changeValue(val ?? "");
                    var result = await Fetcher.fetchData(val ?? "");
                    recipeModels.changeRecipes(result);
                  }
                }
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          buildHeader(
              screenHeight, "WELCOME BACK", "READY TO MAKE SOME DRINKS?"),
          Expanded(child: Consumer<RecipesModel>(
            builder: (context, recipes, child) {
              return CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return RecipeTile(
                          recipe: recipes.recipes[index],
                          screenHeight: screenHeight,
                          function: () {
                            recipes.addFavourite(index);
                            addFavourite(recipes.recipes[index]);
                          },
                          navigate: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => DetailsPage(index: index)));
                          },
                          icon: recipes.recipes[index].isFavourite
                              ? Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                )
                              : Icon(
                                  Icons.star_outline,
                                  color: Colors.white,
                                ),
                        );
                      },
                      childCount: recipes.recipes.length,
                    ),
                  ),

                  // for (var recipe in recipeModels.recipes)
                  //   RecipeTile(
                  //     recipe: recipe,
                  //     screenHeight: screenHeight,
                  //     function: () {
                  //       //recipes.addFavourite(recipe);
                  //       addFavourite(recipe);
                  //     },
                  //     icon: recipe.isFavourite
                  //         ? Icon(
                  //             Icons.star,
                  //             color: Colors.yellow,
                  //           )
                  //         : Icon(
                  //             Icons.star_outline,
                  //             color: Colors.white,
                  //           ),
                  //   ),
                ],
              );
            },
          )),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/common/common.dart';
import 'package:recipeapp/styling/styling.dart';
import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsPage extends StatelessWidget {
  final int index;
  DetailsPage({required this.index});

  Future<void> addFavourite(BuildContext context, Recipe val, int index) async {
    Provider.of<RecipesModel>(context, listen: false).addFavourite(index);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(val.id, json.encode(val.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<RecipesModel>(
          builder: (context, recipes, child) {
            return CustomScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  _customAppBar(
                      width, height, context, recipes.recipes[index], index),
                  SliverPadding(
                    padding: EdgeInsets.only(top: 15, left: 10),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        "INGRIDIENTS: ",
                        style: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, item) {
                      return ListTile(
                        subtitle: Divider(
                          color: Colors.grey,
                          endIndent: width * 0.2,
                          thickness: 0.5,
                          height: 1,
                        ),
                        title: Text(
                          recipes.recipes[index].ingridients[item],
                          style: Styles.ingridientStyle,
                        ),
                      );
                    }, childCount: recipes.recipes[index].ingridients.length),
                  ),
                  SliverFillRemaining(
                    fillOverscroll: true,
                    hasScrollBody: false,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Palette.primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "RECIPE: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30, color: Colors.white70),
                            ),
                            SizedBox(height: 20),
                            Text(
                              recipes.recipes[index].instructions,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                ]);
          },
        ));
  }

  SliverAppBar _customAppBar(double width, double height, BuildContext context,
      Recipe recipe, int index) {
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      floating: true,
      snap: true,
      leading: IconButton(
        splashRadius: 10,
        iconSize: 24,
        icon: Icon(
          Icons.arrow_back_ios_sharp,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          iconSize: 40,
          onPressed: () {
            addFavourite(context, recipe, index);
          },
          icon: recipe.isFavourite
              ? Icon(
                  Icons.star,
                  color: Colors.yellow,
                )
              : Icon(
                  Icons.star_outline,
                  color: Colors.white,
                ),
        )
      ],
      backgroundColor: Colors.white,
      flexibleSpace: CustomizableSpaceBar(
        builder: (context, scrollingRate) {
          return Container(
            decoration: BoxDecoration(
              //color: Palette.primaryColor,
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(recipe.image)),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Container(
              height: 300,
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: height * 0.05,
                    width: width * 0.4,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: AutoSizeText(
                        recipe.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: Styles.detailsPageRow,
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.05,
                    width: width * 0.4,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: AutoSizeText(
                        recipe.description,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: Styles.detailsPageRow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      expandedHeight: 200,
      collapsedHeight: 150,
    );
  }
}

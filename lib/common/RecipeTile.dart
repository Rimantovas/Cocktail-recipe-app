import 'package:flutter/material.dart';
import 'package:recipeapp/common/Recipe.dart';
import 'package:recipeapp/screens/details_screen.dart';
import 'package:recipeapp/styling/palette.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  final double screenHeight;
  final VoidCallback function;
  final VoidCallback navigate;
  final Icon icon;
  RecipeTile(
      {required this.recipe,
      required this.screenHeight,
      required this.function,
      required this.icon,
      required this.navigate});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        height: screenHeight * 0.3,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Palette.gradient1, Palette.gradient2],
          ),
          image: DecorationImage(
              image: NetworkImage(recipe.image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.multiply)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: navigate,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Colors.black.withOpacity(0.4)),
                          child: Text(
                            recipe.description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child:
                    IconButton(iconSize: 40, onPressed: function, icon: icon)),
          ],
        ));
  }
}

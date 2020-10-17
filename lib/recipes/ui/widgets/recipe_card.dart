import 'package:flutter/material.dart';
import 'package:meal_app/recipes/models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  const RecipeCard({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(recipe.strMealThumb),
        ),
        title: Text(recipe.strMeal??""),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:meal_app/recipes/models/recipe.dart';
import 'package:meal_app/recipes/ui/widgets/recipe_card.dart';

class RecipesList extends StatelessWidget {
  final List<Recipe> recipes;
  const RecipesList({Key key, this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: recipes.length,
        itemBuilder: (BuildContext context, int index) {
          return RecipeCard(recipe: recipes[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Color(0xFFff9800).withOpacity(0.15),
            height: 1.0,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meal_app/recipes/bloc/recipes_bloc.dart';
import 'package:meal_app/recipes/models/recipe.dart';
import 'package:meal_app/recipes/ui/widgets/recipes_list.dart';

class CustomSearchDelegate extends SearchDelegate {
  final RecipesBloc recipesBloc;

  CustomSearchDelegate(this.recipesBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    recipesBloc.searchRecipes(query);
    return buildMatchingSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    recipesBloc.searchRecipes(query);
    return buildMatchingSuggestions(context);
  }

  Widget buildMatchingSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: recipesBloc.recipeResult$,
      builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
        if (snapshot.hasData) {
           if(snapshot.data.length==0) return Center(child: Text("No hay resultados"),);
          final List<Recipe> recipes = snapshot.data;
          return RecipesList(recipes: recipes);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

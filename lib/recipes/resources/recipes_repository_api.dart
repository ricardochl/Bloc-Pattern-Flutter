import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meal_app/recipes/models/recipe.dart';
import 'package:meal_app/recipes/models/meal.dart';

class RecipesRepositoryAPI {
  RecipesRepositoryAPI._privateConstructor();

  static final RecipesRepositoryAPI instance = RecipesRepositoryAPI._privateConstructor();



  Future<List<Recipe>> searchRecipes(String query) async {
    print("Search in API");
    final response = await http
        .get('https://www.themealdb.com/api/json/v1/1/search.php?s=$query');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> recipes = data['meals'];

      if (recipes != null) {
        return recipes.map((item) => Recipe.fromJson(item)).toList();
      } else {
        return List<Recipe>();
      }
    } else {
      throw Exception("Error al buscar");
    }
  }

  Future<List<Meal>> getMeals() async {
    final response = await http
        .get("https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian");
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> meals = data['meals'];
      return meals.map((item) => Meal.fromJson(item)).toList();
    } else {
      throw Exception("Error al cargar");
    }
  }
}

import 'package:meal_app/recipes/models/meal.dart';
import 'package:meal_app/recipes/models/recipe.dart';
import 'package:meal_app/recipes/resources/recipes_repository_api.dart';

class RecipesRepository {

  RecipesRepository._privateConstructor(){
    print("hold a ");
  }

  static final RecipesRepository instance = RecipesRepository._privateConstructor();


  final RecipesRepositoryAPI _recipesRepositoryAPI = RecipesRepositoryAPI.instance;

  Future<List<Recipe>> searchRecipes(String query) =>_recipesRepositoryAPI.searchRecipes(query);
  Future<List<Meal>> getMeals() => _recipesRepositoryAPI.getMeals();
}

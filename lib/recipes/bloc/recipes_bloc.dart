import 'package:meal_app/recipes/models/meal.dart';
import 'package:meal_app/recipes/models/recipe.dart';
import 'package:meal_app/recipes/resources/recipes_repository.dart';
import 'package:meal_app/shared/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class RecipesBloc extends BlocBase {
  final RecipesRepository _recipesRepository = RecipesRepository.instance;
  //RecipesRepository();

  final _seachRecipes = BehaviorSubject<String>();
  void searchRecipes(String query) => _seachRecipes.add(query);

  //final _recipesResult = BehaviorSubject<List<Recipe>>();
  //Stream<List<Recipe>> get recipeResult$ => _recipesResult.stream;

  Stream<List<Recipe>> _recipesResult;
  Stream<List<Recipe>> get recipeResult$ => _recipesResult;

  final _mealsSubject = PublishSubject<List<Meal>>();
  Stream<List<Meal>> get meals$ => _mealsSubject.stream;

  RecipesBloc() {
    // _seachRecipes.listen((query) async {\
    // print('searching: $query');
    //   final result = await _recipesRepository.searchRecipes(query);
    //    print('received result for: $query');
    //   _recipesResult.add(result);
    // });
   _recipesResult =  _seachRecipes
                  .debounce((_) => TimerStream(true, Duration(milliseconds: 500)))
                  .switchMap((query) async* {
                   print('searching: $query');
                      yield await _recipesRepository.searchRecipes(query);
                  });
  }

  getMeals() async {
    try {
      List<Meal> meals = await _recipesRepository.getMeals();
      _mealsSubject.add(meals);
    } catch (e) {}
  }

  void dispose() {
    _seachRecipes?.close();
    // _recipesResult?.close();
    _mealsSubject?.close();
  }
}

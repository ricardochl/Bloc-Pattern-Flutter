import 'package:flutter/material.dart';
import 'package:meal_app/recipes/bloc/recipes_bloc.dart';
import 'package:meal_app/recipes/models/meal.dart';
import 'package:meal_app/recipes/ui/widgets/custom_search_delegate.dart';
import 'package:provider/provider.dart';

class HomeRecipes extends StatefulWidget {
  const HomeRecipes({Key key}) : super(key: key);

  @override
  _HomeRecipesState createState() => _HomeRecipesState();
}

class _HomeRecipesState extends State<HomeRecipes> {
  RecipesBloc recipesBloc;

  @override
  void initState() {
    super.initState();
    recipesBloc = Provider.of<RecipesBloc>(context, listen: false);
    recipesBloc.getMeals();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Meal App'),
              floating: true,
              snap: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(recipesBloc),
                    );
                  },
                ),
              ],
            ),
            StreamBuilder(
              stream: recipesBloc.meals$,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Meal>> snapshot) {
                if (snapshot.hasData) {
                  return _buildMeals(snapshot.data);
                } else {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator()
                    )
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMeals(List<Meal> meals) {
    return SliverPadding(
      padding: EdgeInsets.all(20.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            Meal meal = meals[index];
            return _buildMeal(meal);
          },
          childCount: meals.length,
        ),
      ),
    );
  }

  Widget _buildMeal(Meal meal) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(meal.strMealThumb),
            ),
            SizedBox(
              height: 10,
            ),
            Text(meal.strMeal ?? "", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[700]),)
          ],
        ));
  }
}

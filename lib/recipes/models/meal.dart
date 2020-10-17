class Meal{

  String idMeal;
  String strMeal;
  String strMealThumb;

  Meal({
    this.idMeal,
    this.strMeal,
    this.strMealThumb
  });

    factory Meal.fromJson(Map<String, dynamic> json){
    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb']
    );  
  } 
}
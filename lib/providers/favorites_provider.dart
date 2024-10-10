import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';

class favoriteMealsNotifier extends StateNotifier<List<Meal>>
{
favoriteMealsNotifier() : super([]);

bool toggleMealFavoriteStatus(Meal meal){

  final mealsFavorite = state.contains(meal);

  if(mealsFavorite){
  state = state.where((m) => m.id !=meal.id).toList();
  return false;
  } else {
    state = [...state, meal];
    return true;
  }
}
}

final favoriteMealsProvider = StateNotifierProvider<favoriteMealsNotifier, List<Meal>>((ref) {
  return favoriteMealsNotifier();
},);
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class filtersNotifier extends StateNotifier<Map<Filter, bool>> {
  filtersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = is Active; // not allowed! => mutating state
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<filtersNotifier, Map<Filter, bool>>(
  (ref) => filtersNotifier(),
);

final filterdMealsProvider = Provider((ref){
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
return 
      meals.where((Meal) {
      if (activeFilters[Filter.glutenFree]! && !Meal.isGlutenFree){
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !Meal.isLactoseFree){
        return false;
      }
      if (activeFilters[Filter.vegan]! && !Meal.isVegan){
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !Meal.isVegetarian){
        return false;
      }
      return true;
     
    }).toList();
});
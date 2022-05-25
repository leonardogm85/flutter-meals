import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {
  const CategoriesMealsScreen({
    Key? key,
    required this.meals,
  }) : super(key: key);

  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    final Category category =
        ModalRoute.of(context)!.settings.arguments as Category;

    final List<Meal> categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (_, index) {
          return MealItem(
            meal: categoryMeals[index],
          );
        },
      ),
    );
  }
}

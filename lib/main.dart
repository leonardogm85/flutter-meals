import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> availableMeals = dummyMeals;

  void _filterMeals(Settings settings) {
    setState(() {
      availableMeals = dummyMeals.where((meal) {
        if (settings.isGlutenFree && !meal.isGlutenFree) {
          return false;
        }

        if (settings.isLactoseFree && !meal.isLactoseFree) {
          return false;
        }

        if (settings.isVegan && !meal.isVegan) {
          return false;
        }

        if (settings.isVegetarian && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: Colors.amber,
        ),
        fontFamily: 'Raleway',
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      routes: {
        AppRoutes.home: (_) => const TabsScreen(),
        AppRoutes.settings: (_) => SettingsScreen(
              onSettingsChanged: _filterMeals,
            ),
        AppRoutes.categoriesMeals: (_) => CategoriesMealsScreen(
              meals: availableMeals,
            ),
        AppRoutes.mealDetail: (_) => const MealDetailScreen(),
      },
    );
  }
}

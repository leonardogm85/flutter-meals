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
  Settings settings = Settings();
  List<Meal> availableMeals = dummyMeals;
  List<Meal> favoriteMeals = [];

  void _filterMeals(Settings newSettings) {
    setState(() {
      settings = newSettings;

      availableMeals = dummyMeals.where((meal) {
        if (newSettings.isGlutenFree && !meal.isGlutenFree) {
          return false;
        }

        if (newSettings.isLactoseFree && !meal.isLactoseFree) {
          return false;
        }

        if (newSettings.isVegan && !meal.isVegan) {
          return false;
        }

        if (newSettings.isVegetarian && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      if (favoriteMeals.contains(meal)) {
        favoriteMeals.remove(meal);
      } else {
        favoriteMeals.add(meal);
      }
    });
  }

  bool _isFavorite(Meal meal) {
    return favoriteMeals.contains(meal);
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
        AppRoutes.home: (_) => TabsScreen(
              favoriteMeals: favoriteMeals,
            ),
        AppRoutes.settings: (_) => SettingsScreen(
              onSettingsChanged: _filterMeals,
              settings: settings,
            ),
        AppRoutes.categoriesMeals: (_) => CategoriesMealsScreen(
              meals: availableMeals,
            ),
        AppRoutes.mealDetail: (_) => MealDetailScreen(
              onToggleFavorite: _toggleFavorite,
              isFavorite: _isFavorite,
            ),
      },
    );
  }
}

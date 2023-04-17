import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import './models/meal.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/category_meals_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
//import 'package:meal_app/models/category.dart';
import 'package:meal_app/screens/meal_details_screen.dart';
import 'package:meal_app/screens/tab_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters={
'gluten': false,
'vegetarian': false,
'lactose': false,
'vegan': false,
  };
List<Meal> _availableMeals= dummyMeals;
List<Meal> _favouriteMeals=[];
  void _setFilters(Map<String, bool> filterdata){
  setState(() {
    _filters=filterdata;

    _availableMeals= dummyMeals.where((meal){
      if(_filters['gluten']! && !meal.isGlutenFree){
        return false;
      }
      if(_filters['vegetarian']! && !meal.isVegetarian){
        return false;
      }
      if(_filters['lactose']! && !meal.isLactoseFree){
        return false;
      }
      if(_filters['vegan']! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();
  });
}

void _toggleFavourite(String mealId){
final existingIndex=
_favouriteMeals.indexWhere((meal) => meal.id==mealId);
if(existingIndex>=0){
  setState(() {
    _favouriteMeals.removeAt(existingIndex);
  });
}
else{
  setState(() {
    _favouriteMeals.add(dummyMeals.firstWhere((meal) => meal.id==mealId));
  });
}
}

bool _isMealFavourite(String id){
  return _favouriteMeals.any((meal) => meal.id==id);
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMEALS',
      theme: ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.amber,
  canvasColor: const Color.fromRGBO(255, 254, 229, 1),
  fontFamily: 'Raleway',
  textTheme: ThemeData.light().textTheme.copyWith(
    bodyText1: const TextStyle(
      color: Color.fromRGBO(20, 51, 51, 1),
    ),
    bodyText2: const TextStyle(
      color: Color.fromRGBO(20, 51, 51, 1),
    ),
    headline6: const TextStyle(
      fontSize: 20,
      fontFamily: 'RobotoCondensed',
      fontWeight: FontWeight.bold,
    ),
  ),
      ),
      //home: Categories_screen(),
      initialRoute: '/',
      routes: {
        '/':(ctx)=> TabScreen (_favouriteMeals),
        CategoryMealsScreen.routeName: (ctx)=>CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName:(ctx)=> MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FiltersScreen.routeName:(ctx)=>FiltersScreen(_filters,_setFilters),
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder:(ctx)=> const categoriesScreen());
      },
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeliMeals'),
      ),
      body: const Center(
        child: Text('navigation time!'),
      ),
    );
  }
}

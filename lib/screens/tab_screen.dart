import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/favourite_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import'../models/meal.dart';

class TabScreen extends StatefulWidget {
  
final List<Meal> favouriteMeals;
  TabScreen(this.favouriteMeals);
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  
  late List<Map<String,Object>> _pages;
  int _selectPageIndex=0;
@override
  void initState() {
  _pages= [
  {'page':const categoriesScreen(),'title':'Categories'},
  {'page': FavouriteScreen(widget.favouriteMeals),'title':'Your Favourite'},
  ];
    super.initState();
  }

  void _selectPage(int index){
setState(() {
  _selectPageIndex=index;
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(_pages[_selectPageIndex]['title'] as String),
        ),
        drawer:const MyDrawer(),
      body: _pages[_selectPageIndex]['page'] as Widget,
      bottomNavigationBar: 
      BottomNavigationBar(
        onTap:_selectPage ,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: const Icon(Icons.category),
          label:'Categories',
          ),

          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
          icon: const Icon(Icons.category),
          label:'Favourites',
          ),
      ]),
    );
  }
}
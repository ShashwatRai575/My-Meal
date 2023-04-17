import 'package:flutter/material.dart';
import 'package:meal_app/screens/filters_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  Widget buildListTile(String title, IconData icon,VoidCallback tapHandler){
    return ListTile(
          leading: Icon(
            icon,
            size:26,
            ),
            title: Text(title,
            style:const TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 24,
              fontWeight: FontWeight.bold
            )),
            onTap: tapHandler,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        Container(
          height: 120,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).accentColor,
          child: Text('cooking',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: Theme.of(context).primaryColor,
            ),),
        ),
        const SizedBox(height: 20,),
        buildListTile('Meals', Icons.restaurant_outlined,(){
          Navigator.of(context).pushReplacementNamed('/');
        }),
        buildListTile('Settings', Icons.settings,
        (){
           Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
        }),
      ],)
    );
  }
}
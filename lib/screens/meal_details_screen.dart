import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName='/meal-detail';
  final Function toggleFavourite;
   final Function isMealFavourite;

  MealDetailScreen(this.toggleFavourite, this.isMealFavourite);

  
Widget buidlSectionTitle(BuildContext context ,String text){
return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
          text,
          style:Theme.of(context).textTheme.titleMedium
          ),
        );

}

Widget buildContainer(Widget child){
  return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 180,width: 300,
          child: child,
          );

}
  @override
  Widget build(BuildContext context) {
    final mealId=ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal=dummyMeals.firstWhere((meal)=>meal.id==mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            
            height:250,
            width: double.infinity,
            child: Image.network(selectedMeal.imageUrl,
            fit: BoxFit.cover,),
          ),
          buidlSectionTitle(context,'Ingredients'),
          buildContainer(
             ListView.builder(
            itemBuilder: (ctx,index)=>Card(color: Theme.of(context).accentColor,
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(selectedMeal.ingredients[index])),
            ),
            itemCount: selectedMeal.ingredients.length, 
            ),
          ),
          
          buidlSectionTitle(context,'Steps'),
          buildContainer(ListView.builder(
            itemBuilder: (ctx,index)=>Column(children: [ListTile(
              leading: CircleAvatar(
                child: Text('# ${index + 1}'),
              ),
              title: Text(selectedMeal.steps[index],
              ),
            ),
            const Divider()
            ],),
            itemCount: selectedMeal.steps.length,
          ))
        ],),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFavourite(mealId)? Icons.star: Icons.star_border,
        ),
        onPressed:()=> toggleFavourite(mealId),
        ),
    );
  }
}
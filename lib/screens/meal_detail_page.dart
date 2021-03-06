import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class MealDetailPage extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavouriteMeal;
  final Function isMealFavourite;

  MealDetailPage({
    this.toggleFavouriteMeal,
    this.isMealFavourite,
  });

  Widget _buildSectionTitle(BuildContext context, String heading) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        heading,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _buildContainer(BuildContext context, Widget childWidget) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: childWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final mealId = routeArgs['id'];
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(
              context,
              'Ingredients',
            ),
            _buildContainer(
                context,
                ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(
                          '${selectedMeal.ingredients[index]}',
                        ),
                      ),
                    );
                  },
                  itemCount: selectedMeal.ingredients.length,
                )),
            _buildSectionTitle(
              context,
              'Steps',
            ),
            _buildContainer(
              context,
              ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${index + 1}'),
                          ),
                          title: Text(selectedMeal.steps[index]),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                      ],
                    );
                  },
                  itemCount: selectedMeal.steps.length),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          this.isMealFavourite(mealId) ? Icons.star : Icons.star_outline,
        ),
        onPressed: () {
          //Navigator.of(context).pop({'id': mealId});
          this.toggleFavouriteMeal(mealId);
        },
      ),
    );
  }
}

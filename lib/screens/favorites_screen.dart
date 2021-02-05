import 'package:flutter/material.dart';
import 'package:mealapp2/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:mealapp2/providers/meal_provider.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';



class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var lan = Provider.of<LanguageProvider>(context , listen : true);
    final List<Meal> favoriteMeals = Provider.of<MealProvider>(context , listen: true).favoriteMeals;

    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(lan.getTexts("favorites_text")),
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw<=400 ? 400 : 500,
          childAspectRatio: isLandScape?  dw/(dw*1.27):dw/(dw*1.05),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            affordability: favoriteMeals[index].affordability,
            complexity: favoriteMeals[index].complexity,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}

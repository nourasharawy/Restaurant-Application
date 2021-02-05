import 'package:flutter/material.dart';
import 'package:mealapp2/providers/language_provider.dart';
import 'package:mealapp2/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category-meals';


  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryId;
  List<Meal> displayedMeals;

  @override
  void didChangeDependencies() {
      final List<Meal> availableMeals = Provider.of<MealProvider>(context , listen: true).availableMeals;
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryId = routeArgs['id'];
      displayedMeals = availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var lan = Provider.of<LanguageProvider>(context , listen: true);

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(lan.getTexts('cat-$categoryId'))),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw<=400 ? 400 : 500,
            childAspectRatio: isLandScape?  dw/(dw*1.05):dw/dw,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              imageUrl: displayedMeals[index].imageUrl,
              //title:displayedMeals[index].title,
              duration: displayedMeals[index].duration,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
            );
          },
          itemCount: displayedMeals.length,
        ),
      ),
    );
  }
}

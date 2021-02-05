import 'package:flutter/material.dart';
import 'package:mealapp2/models/category.dart';
import 'package:mealapp2/providers/language_provider.dart';

import 'package:mealapp2/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context , listen: true);
    return Scaffold(
      body: GridView(
        padding: lan.isEn ? EdgeInsets.all(7) : EdgeInsets.all(0),
        children: Provider.of<MealProvider>(context).availableCategory
            .map(
              (catData) => CategoryItem(
                    catData.id, catData.color,
                  ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mealapp2/providers/meal_provider.dart';
import 'package:mealapp2/providers/language_provider.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = 'meal-detail';

  _MealDetailScreen_State createState() => _MealDetailScreen_State();
}

class _MealDetailScreen_State extends State<MealDetailScreen> {
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.headline6, textAlign :TextAlign.center,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      height: isLandScape ? (dh * 0.5 - 30) : dh * 0.25,
      width: isLandScape ? (dw * 0.5 - 30) : dw,
      child: child,
    );
  }

  String mealId;

  @override
  void didChangeDependencies() {
    mealId = ModalRoute.of(context).settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    //final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var accentColor = Theme.of(context).accentColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    List<String> stepsLi = lan.getTexts("steps-$mealId") as List<String>;
    var liSteps = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('#${index + 1}'),
            ),
            title: Text(
              stepsLi[index],
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider()
        ],
      ),
      itemCount: stepsLi.length,
    );

    List<String> liIngrediantLi =
        lan.getTexts("ingredients-$mealId") as List<String>;
    var liIngrediants = ListView.builder(
      padding : EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(
              liIngrediantLi[index],
              style: TextStyle(
                  color: useWhiteForeground(accentColor)
                      ? Colors.white
                      : Colors.black),
            )),
      ),
      itemCount: liIngrediantLi.length,
    );
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(lan.getTexts("meal-$mealId")),
                background : Hero(
                  tag: mealId,
                  child: InteractiveViewer(
                    child: FadeInImage(
                      placeholder: AssetImage("assets/images/a2.png"),
                      image: NetworkImage(selectedMeal.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [isLandScape
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                buildSectionTitle(
                                    context, lan.getTexts('Ingredients')),
                                buildContainer(liIngrediants),
                              ],
                            ),
                            Column(
                              children: [
                                buildSectionTitle(context, 'Steps'),
                                buildContainer(liSteps),
                              ],
                            ),
                          ],
                        )
                      : !isLandScape
                          ? buildSectionTitle(
                              context, lan.getTexts('Ingredients'))
                          : Container(),
                  !isLandScape ? buildContainer(liIngrediants) : Container(),
                  !isLandScape
                      ? buildSectionTitle(context, 'Steps')
                      : Container(),
                  !isLandScape ? buildContainer(liSteps) : Container(),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .toggleFavorite(mealId),
          child: Icon(
            Provider.of<MealProvider>(context, listen: true)
                    .isMealFavorite(mealId)
                ? Icons.star
                : Icons.star_border,
          ),
        ),
      ),
    );
  }
}

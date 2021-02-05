import 'package:flutter/material.dart';
import 'package:mealapp2/providers/language_provider.dart';
import 'package:provider/provider.dart';
import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem(
      {
        @required this.id,
        @required this.imageUrl,
        @required this.duration,
        @required this.complexity,
        @required this.affordability,

      });


  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context , listen: true);
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Hero(
                    tag: id,

                    child: InteractiveViewer(
                      child: FadeInImage(
                        width:double.infinity,
                        placeholder: AssetImage("assets/images/a2.png"),
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      lan.getTexts("meal-$id"),
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.schedule,
                        color: Theme.of(context).buttonColor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      duration<=10
                          ? Text('$duration ' + lan.getTexts("min2"))
                          : Text('$duration ' + lan.getTexts("min")),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.work, color: Theme.of(context).buttonColor,),
                      SizedBox(
                        width: 6,
                      ),
                      Text(lan.getTexts("$complexity")),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: Theme.of(context).buttonColor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(lan.getTexts("$affordability")),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mealapp2/providers/language_provider.dart';
import 'package:mealapp2/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:mealapp2/providers/meal_provider.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final bool fromOnBoarding ;
  FiltersScreen({ this.fromOnBoarding =false});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: false).filters;
    _glutenFree = currentFilters['gluten'];
    _lactoseFree = currentFilters['lactose'];
    _vegetarian = currentFilters['vegetarian'];
    _vegan = currentFilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
      inactiveTrackColor:
          Provider.of<ThemeProvider>(context, listen: true).tm ==
                  ThemeMode.light
              ? null
              : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;
    var lan = Provider.of<LanguageProvider>(context , listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer:widget.fromOnBoarding ? null :  MainDrawer(),
        body: CustomScrollView(
          slivers :[
            SliverAppBar(
              pinned: false,
              title : widget.fromOnBoarding?null : Text (lan.getTexts("filters_appBar_title") , textAlign:TextAlign.center ) ,
              backgroundColor :widget.fromOnBoarding? null :Theme.of(context).canvasColor,
                elevation:widget.fromOnBoarding? 0:5,
            ),
            SliverList( delegate : SliverChildListDelegate([
              Container(
                padding: EdgeInsets.all(20),
                child: Text (lan.getTexts("filters_screen_title"),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              _buildSwitchListTile(
                lan.getTexts("Gluten-free"),
                lan.getTexts("Gluten-free-sub"),
                currentFilters['gluten'],
                    (newValue) {
                  setState(() {
                    currentFilters['gluten'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                },
              ),
              _buildSwitchListTile(
                lan.getTexts("Lactose-free"),
                lan.getTexts("Lactose-free_sub"),
                currentFilters['lactose'],
                    (newValue) {
                  setState(() {
                    currentFilters['lactose'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                },
              ),
              _buildSwitchListTile(
                lan.getTexts("Vegetarian"),
                lan.getTexts("Vegetarian-sub"),
                currentFilters['vegetarian'],
                    (newValue) {
                  setState(() {
                    currentFilters['vegetarian'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                },
              ),
              _buildSwitchListTile(
                lan.getTexts("Vegan"),
                lan.getTexts("Vegan-sub"),
                currentFilters['vegan'],
                    (newValue) {
                  setState(
                        () {
                      currentFilters['vegan'] = newValue;
                    },
                  );
                },
              ),
              SizedBox(height: widget.fromOnBoarding ? 100 : 0),
            ],),),
          ],
        ),
      ),
    );
  }
}

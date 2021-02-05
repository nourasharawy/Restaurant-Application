import 'package:flutter/material.dart';
import 'package:mealapp2/providers/language_provider.dart';
import 'package:mealapp2/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:mealapp2/providers/meal_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs-screen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    Provider.of<MealProvider>(context , listen: false).getData();
    Provider.of<ThemeProvider>(context , listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context , listen: false).getThemeColors();
    Provider.of<LanguageProvider>(context , listen: false).getLan();
    super.initState();
  }
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context , listen: true);
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': lan.getTexts("categories"),
      },
      {
        'page': FavoritesScreen(),
        'title': lan.getTexts("your_favorites"),
      },
    ];

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(_pages[_selectedPageIndex]['title']),),
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          // type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text(lan.getTexts("categories")),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text(lan.getTexts("your_favorites")),
            ),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}

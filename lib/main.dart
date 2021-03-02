import 'package:flutter/material.dart';
import 'package:service_search_app/screens/home_screen.dart';
import 'package:service_search_app/screens/search_screen.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => HomeScreen(),
      '/search': (BuildContext context) => SearchScreen()
    },
  ));
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_search_app/bloc/search_bloc.dart';
import 'package:service_search_app/screens/home_screen.dart';
import 'package:service_search_app/screens/search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<SearchBloc>(
      create: (context) => SearchBloc(),
      dispose: (context, bloc) => bloc.dipose,
      child: MaterialApp(
        home: HomeScreen(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeScreen(),
          '/search': (BuildContext context) => SearchScreen()
        },
      ),
    );
  }
}

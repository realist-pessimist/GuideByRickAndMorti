import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/personlist/person_list_page.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    '/Home': (BuildContext context) => PersonListPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick And Morty',
      theme: new ThemeData(
          primaryColor: Colors.black,
          fontFamily: 'Raleway'
      ),
      home: SplashScreen(nextRoute: "/Home"),
      routes: routes,
    );
  }
}

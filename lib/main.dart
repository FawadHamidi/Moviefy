import 'package:flutter/material.dart';
import 'package:moviefy/Services/database_helper/database.dart';

import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

import 'Screens/home_screen.dart';
import 'Services/database_helper/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await locator<DatabaseHelper>().database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApiProvider>(
          create: (context) => ApiProvider(),
        ),
        ChangeNotifierProvider<DatabaseHelper>(
          create: (context) => DatabaseHelper(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Moviefy',
        home: MyHomePage(),
      ),
    );
  }
}

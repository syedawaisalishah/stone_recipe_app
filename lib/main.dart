import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stone_recipe_app/djangoapi.dart';
import 'package:stone_recipe_app/favoritehomepage.dart';
import 'package:stone_recipe_app/favoritepage.dart';
import 'package:stone_recipe_app/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stone_recipe_app/services/db_services.dart';

import 'models/recipe.dart';

const String FavoriteBox = 'favorite';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(FavoriteBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}


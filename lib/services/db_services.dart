import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stone_recipe_app/models/recipe.dart';

class DataBaseService {
  late Database _db;
  initDatabase() async {
    _db = await openDatabase(
      'assets/recipe.sqlite',
    );
    var databasepath = await getDatabasesPath();
    var path = join(databasepath, 'recipe.sqlite');

    var exists = await databaseExists(path);
    if (!exists) {
      print('create a new copy from assets');

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      //copy from assets
      ByteData data = await rootBundle.load(join('assets', 'recipe.sqlite'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //write and flushe bytes
      await File(path).writeAsBytes(bytes, flush: true);
    }
    _db = await openDatabase(path, readOnly: false);
  }

  Future<List<Recipe>> getRecipe() async {
    await initDatabase();
    List<Map<String, dynamic>> list = await _db.rawQuery('SELECT * from chines_recipe');

    return list.map((recipe) => Recipe.fromJson(recipe)).toList();
  }

  Future<List<RecipeCat>> getCategory() async {
    await initDatabase();
    List<Map<String, dynamic>> list = await _db.rawQuery('SELECT DISTINCT(recipe_cat) from chines_recipe');

    return list.map((recipecat) => RecipeCat.fromJson(recipecat)).toList();
  }

  // Future<List<Recipe>> getsubcat() async {
  //   await initDatabase();
  //   String b = 'chinese';
  //   List<Map<String, dynamic>> list = await _db.rawQuery('SELECT * from chines_recipe where recipe_cat=?', [b]);

  //   return list.map((recipe) => Recipe.fromJson(recipe)).toList();
  // }

  Future<List<Recipe>> getsub(String a) async {
    await initDatabase();
    List<Map<String, dynamic>> list = await _db.rawQuery('SELECT * from chines_recipe where recipe_cat=?', [a]);

    return list.map((recipe) => Recipe.fromJson(recipe)).toList();
  }

  Future<List<Recipe>> getid(int recipe_id) async {
    await initDatabase();
    List<Map<String, dynamic>> list = await _db.rawQuery('SELECT * from chines_recipe where recipe_id=?', [recipe_id]);

    return list.map((recipe) => Recipe.fromJson(recipe)).toList();
  }

  Future<void> updatevalue(int b, int value) async {
    await initDatabase();

    await _db.rawQuery('UPDATE chines_recipe SET favorites=$value where recipe_id==$b');
  }

// A method that retrieves all the dogs from the dogs table.
  Future<List<Recipe>> readdata() async {
    // Get a reference to the database.
    await initDatabase();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await _db.query('chines_recipe');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Recipe(
        recipe_id: maps[i]['recipe_id'],
        recipe_name: maps[i]['recipe_name'],
        recipe_ingrdients: maps[i]['recipe_ingrdients'],
        recipe_prep: maps[i]['recipe_prep'],
        recipe_cat: maps[i]['recipe_cat'],
        image_name: maps[i]['image_name'],
        favorites: maps[i]['favorites'],
      );
    });
  }

  Future<void> updaterecipe(Recipe recipe) async {
    // Get a reference to the database.
    await initDatabase();

    // Update the given Dog.
    await _db.update(
      'chines_recipe',
      recipe.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id=?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [recipe.recipe_id],
    );
  }

  dispose() {
    _db.close();
  }
}

import 'package:flutter/material.dart';
import 'package:stone_recipe_app/models/recipe.dart';
import 'package:share_plus/share_plus.dart';

class DetailedScreen extends StatelessWidget {
  DetailedScreen({Key? key, required this.recipe, required this.index}) : super(key: key);
  List<Recipe>? recipe;
  int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe![index].recipe_name),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(recipe![index].recipe_cat),
              Text(recipe![index].recipe_prep),
              Text(recipe![index].recipe_id.toString()),
              Text(recipe![index].recipe_ingrdients),
              Text(recipe![index].image_name),
              OutlinedButton(
                  onPressed: () {
                    Share.share(recipe![index].recipe_prep);
                  },
                  child: Text('Share'))
            ],
          ),
        ),
      ),
    );
  }
}

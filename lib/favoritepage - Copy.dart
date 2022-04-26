import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stone_recipe_app/provider/bookmarks_model.dart';
import 'package:stone_recipe_app/services/db_services.dart';

import 'models/recipe.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final dbservice = DataBaseService();

  bool _isfavorite = true;
  int recipe_id = 1;
  String recipe_name = 's';
  String recipe_ingrdients = 'ss';
  String recipe_prep = 'sos';
  String recipe_cat = 'as';
  String image_name = 's';
  int favorites = 1;
  @override
  void dispose() {
    dbservice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bookmarkBloc = Provider.of<Bookmarkbloc>(context);
    dbservice.readdata();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff007AFF)),
        title: Text('Favorite', style: TextStyle(color: Color(0xff007AFF))),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30,
            ),
          )
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Recipe>>(
          future: dbservice.readdata(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {},
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          OutlinedButton(
                              onPressed: () async {
                                // Update Fido's age and save it to the database.
                                setState(() {
                                  dbservice.updaterecipe(Recipe(
                                    recipe_id: recipe_id,
                                    recipe_name: recipe_name,
                                    recipe_ingrdients: recipe_ingrdients,
                                    recipe_prep: recipe_prep,
                                    recipe_cat: recipe_cat,
                                    image_name: image_name,
                                    favorites: favorites,
                                  ));
                                });
// Print the updated results.
                                // Prints Fido with age 42.
                              },
                              child: Text('update')),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            child: Center(
                              child: Text(
                                snapshot.data![index].recipe_cat,
                                style: TextStyle(color: Colors.green, fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ));
              },
            );
          },
        ),
      ),
    );
  }
}

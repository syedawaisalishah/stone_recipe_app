import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stone_recipe_app/detailedScreen.dart';
import 'package:stone_recipe_app/favoritepage.dart';
import 'package:stone_recipe_app/homepage.dart';
import 'package:stone_recipe_app/main.dart';
import 'package:stone_recipe_app/models/recipe.dart';
import 'package:stone_recipe_app/services/db_services.dart';

const String FavoriteBox = 'favorite';

class SubCategory extends StatefulWidget {
  List<RecipeCat> RecipeCategory = [];
  late int index;
  SubCategory({
    Key? key,
  }) : super(key: key);

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  final dbservice = DataBaseService();
  late String title;
  late String subtitle;
  late int ids;

  bool _isfavorite = true;

  @override
  void dispose() {
    dbservice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? catdata = ModalRoute.of(context)!.settings.arguments.toString();

    var box = Hive.box(FavoriteBox);

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Favorite()),
                );
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30,
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              Text(
                'All Recipe',
                style: TextStyle(color: Color(0xff007AFF)),
              )
            ],
          ),
          iconTheme: IconThemeData(color: Color(0xff007AFF)),
          title: Center(
            child: Text(catdata!, style: TextStyle(color: Colors.black)),
          ),
        ),
        body: Container(
          child: ValueListenableBuilder(
              valueListenable: Hive.box(FavoriteBox).listenable(),
              builder: (context, box, child) {
                return FutureBuilder<List<Recipe>>(
                  future: dbservice.getsub(catdata),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        ids = snapshot.data![index].recipe_id;
                        return Column(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailedScreen(
                                        recipe: snapshot.data,
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                      image: DecorationImage(
                                        image: AssetImage('Recipe/${snapshot.data![index].image_name}.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                      boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black)]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(
                                        snapshot.data![index].image_name,
                                      ),
                                      Text(
                                        snapshot.data![index].recipe_cat,
                                      ),
                                    ]),
                                  ),
                                  IconButton(
                                    icon: Icon(Hive.box(FavoriteBox).containsKey(snapshot.data![index].recipe_id) ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                                    onPressed: () {
                                      if (Hive.box(FavoriteBox).containsKey(snapshot.data![index].recipe_id)) {
                                        Hive.box(FavoriteBox).delete(
                                          snapshot.data![index].recipe_id,
                                        );
                                      } else {
                                        Hive.box(FavoriteBox).put(snapshot.data![index].recipe_id, snapshot.data![index].image_name);
                                      }
                                    },
                                  )
                                  // FavoriteButton(
                                  //   isFavorite: snapshot.data![index].favorites == 0 ? false : true,
                                  //   valueChanged: (isFavorite) {
                                  //     if (isFavorite) {
                                  //       setState(() {
                                  //         dbservice.updatevalue(snapshot.data![index].recipe_id, 1);

                                  //       });
                                  //     } else {
                                  //       setState(() {
                                  //         dbservice.updatevalue(snapshot.data![index].recipe_id, 0);
                                  //       });
                                  //     }
                                  //   },
                                  // ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                    // return ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: snapshot.data?.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return SingleChildScrollView(
                    //       scrollDirection: Axis.vertical,

                    //       // child: ListTile(
                    //       //   onTap: () {
                    //       //     Navigator.push(
                    //       //       context,
                    //       //       MaterialPageRoute(
                    //       //         builder: (context) => DetailedScreen(
                    //       //           recipe: snapshot.data,
                    //       //           index: index,
                    //       //         ),
                    //       //       ),
                    //       //     );
                    //       //   },
                    //       //   leading: Text(snapshot.data![index].recipe_name.toString(), style: TextStyle(color: Colors.black)),
                    //       // ),
                    //     );
                    //   },
                    // );
                  },
                );
              }),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/backimg.jpg'), fit: BoxFit.cover),
          ),
        ));
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stone_recipe_app/djangoapi.dart';
import 'package:stone_recipe_app/favoritehomepage.dart';
import 'package:stone_recipe_app/favoritepage.dart';
import 'package:stone_recipe_app/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stone_recipe_app/main.dart';
import 'package:stone_recipe_app/services/db_services.dart';


const String FavoriteBox = 'favorite';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final dbservice = DataBaseService();
  var box = Hive.box(FavoriteBox);

  @override
  void dispose() {
    dbservice.dispose();
    super.dispose();
  }

  late Box box1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBox();
  }

  void createBox() async {
    box1 = await Hive.openBox(FavoriteBox);
  }

  @override
  Widget build(BuildContext context) {
    List reciplist = List.from(box1.values);

    var keys = box.keys;
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
        body: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, box1, child) {
              return ListView(
                children: [
                  ...reciplist.map((e) => ListTile(
                        title: Text(e),
                        trailing: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            box.delete(reciplist.indexOf(e));
                          },
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        box.clear();
                      },
                      child: const Text("Clear All")),
                ],
              );
            })
        // body: Container(
        //     child: ListView(children: [
        //   ListTile(
        //       title: Text('recipe'),
        //       trailing: IconButton(
        //         icon: Icon(Icons.cancel),
        //         onPressed: () {},
        //       )
        //       // leading: Container(width: 20, height: 40, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('Recipe/Akoori - Indian Scrambled Eggs.jpg')))),
        //       ),
        // ])),
        );
  }
}

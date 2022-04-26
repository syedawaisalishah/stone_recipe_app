import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:stone_recipe_app/favoritedetailedScreen.dart';

import 'package:stone_recipe_app/main.dart';
import 'package:stone_recipe_app/services/db_services.dart';

import 'models/recipe.dart';

class Favorite extends StatefulWidget {
  Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Box box = Hive.box(FavoriteBox);

  @override
  Widget build(BuildContext context) {
    List reciplist = List.from(box.values);
    List keys = List.from(box.keys);

    Map mymap = {
      "values": reciplist,
      "keys": keys,
    };

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xff007AFF)),
          title: Text('Favorite', style: TextStyle(color: Color(0xff007AFF))),
          centerTitle: true,
          actions: [
            Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30,
            )
          ],
        ),
        body: ValueListenableBuilder<Box>(
            valueListenable: Hive.box(FavoriteBox).listenable(),
            builder: (context, box, widget) {
              return ListView.builder(
                  itemCount: mymap["values"].length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Favoritedetailpage(title: mymap["values"][index].toString()), settings: RouteSettings(arguments: mymap["keys"][index].toString())),
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.favorite, color: Colors.red),
                        title: Text(mymap["values"][index].toString()),
                        // subtitle: Text(" The ID is: ${mymap["keys"][index].toString()}"),
                        trailing: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              box.delete(mymap["keys"][index]);
                            });
                          },
                        ),
                      ),
                    );
                    //  Column(
                    //   children: [
                    //     Text(mymap["values"][index].toString()),
                    //     Text(mymap["keys"][index].toString()),
                    //   ],
                    // );
                  }));

              // ListView(
              //   children: [
              //     ...keys.map((e) => GestureDetector(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(builder: (context) => Favoritedetailpage(), settings: RouteSettings(arguments: e)),
              //             );
              //           },
              //           child: ListTile(
              //             title: Text(e.toString()),
              //             //
              //             trailing: IconButton(
              //               icon: Icon(Icons.clear),
              //               onPressed: () {
              //                 setState(() {
              //                   box.delete(e);
              //                 });
              //               },
              //             ),
              //           ),
              //         )),
              //     Padding(
              //       padding: EdgeInsets.all(20),
              //       child: OutlinedButton(
              //           onPressed: () {
              //             setState(() {
              //               box.clear();
              //             });
              //           },
              //           child: Text("Clear All")),
              //     )
              //   ],
              // );
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

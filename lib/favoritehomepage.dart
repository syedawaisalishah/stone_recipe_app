import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stone_recipe_app/provider/bookmarks_model.dart';
import 'package:stone_recipe_app/provider/item_model.dart';

import 'favoritepage.dart';

class FavoriteHomePage extends StatefulWidget {
  const FavoriteHomePage({Key? key}) : super(key: key);

  @override
  State<FavoriteHomePage> createState() => _FavoriteHomePageState();
}

class _FavoriteHomePageState extends State<FavoriteHomePage> {
  List itemlist = [
    {
      'name': 'itemlist1',
      'subname': 'this is itemlist1',
    },
    {
      'name': 'itemlist2',
      'subname': 'this is itemlist2',
    },
    {
      'name': 'itemlist2',
      'subname': 'this is itemlist3',
    },
  ];
  @override
  Widget build(BuildContext context) {
    var bookmarkBloc = Provider.of<Bookmarkbloc>(context);

    return Scaffold(
        appBar: AppBar(title: Text('BookMarksFlutter'), actions: [
          Row(
            children: [
              Text(Bookmarkbloc.count().toString()),
              SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ],
          )
        ]),
        body: SingleChildScrollView(
          child: Column(children: [
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: itemlist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Bookmarkbloc().addcount();
                      print(Bookmarkbloc.count().toString());
                      ItemModel itemModel = ItemModel(name: itemlist[index]['name'], subtitle: itemlist[index]['subname']);
                    },
                    title: Text(itemlist[index]['name']),
                    subtitle: Text(itemlist[index]['subname']),
                    trailing: Icon(Icons.add),
                  );
                })
          ]),
        ));
  }
}

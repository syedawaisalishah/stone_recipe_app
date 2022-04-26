import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';

import '../favoritepage.dart';

Widget customDrawer({context}) {
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('images/drawerimage.jpg'), fit: BoxFit.cover),
      ),
      // child: Text("This is simple drawer"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Favorite()),
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.stars,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Favourites',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ListTile(
                leading: InkWell(
                  onTap: () {
                    Share.share('recipe app download now from google playstore');
                  },
                  child: Icon(
                    Icons.share_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                title: Text(
                  'Share App',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

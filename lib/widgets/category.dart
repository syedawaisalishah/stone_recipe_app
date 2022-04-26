import 'package:flutter/material.dart';

Widget Getdata() {
  List<String> Cat = ['chines', 'chine', 'Indian', 'italian', 'Italian Pizza', 'Rice Recipes', ' Baking and Desserts'];

  return ListView.builder(
    shrinkWrap: true,
    itemCount: Cat.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        onTap: () {},
        leading: Text(Cat[index].toString(), style: TextStyle(color: Colors.black)),
      );
    },
  );
}

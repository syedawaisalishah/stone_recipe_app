import 'package:flutter/material.dart';
import 'package:stone_recipe_app/detailedScreen.dart';
import 'package:stone_recipe_app/homepage.dart';
import 'package:stone_recipe_app/models/recipe.dart';
import 'package:stone_recipe_app/services/db_services.dart';

class SubCategory extends StatefulWidget {
  SubCategory({
    Key? key,
  }) : super(key: key);

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  final dbservice = DataBaseService();

  @override
  void dispose() {
    dbservice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? catdata = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
        appBar: AppBar(title: Text(catdata!)),
        body: FutureBuilder<List<Recipe>>(
          future: dbservice.getsub(catdata),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListTile(
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
                    leading: Text(snapshot.data![index].recipe_name.toString(), style: TextStyle(color: Colors.black)),
                  ),
                );
              },
            );
          },
        ));
  }
}




        //  FutureBuilder<List<Recipe>>(
        //   future: dbservice.getsub(catdata),
        //   builder: (context, snapshot) {
        //     if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        //     return ListView.builder(
        //       shrinkWrap: true,
        //       itemCount: snapshot.data?.length,
        //       itemBuilder: (BuildContext context, int index) {
        //         return SingleChildScrollView(
        //           scrollDirection: Axis.vertical,
                  
        //           // child: ListTile(
        //           //   onTap: () {
        //           //     Navigator.push(
        //           //       context,
        //           //       MaterialPageRoute(
        //           //         builder: (context) => DetailedScreen(
        //           //           recipe: snapshot.data,
        //           //           index: index,
        //           //         ),
        //           //       ),
        //           //     );
        //           //   },
        //           //   leading: Text(snapshot.data![index].recipe_name.toString(), style: TextStyle(color: Colors.black)),
        //           // ),
        //         );
        //       },
        //     );
        //   },
        // )
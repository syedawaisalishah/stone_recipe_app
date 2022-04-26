import 'package:flutter/material.dart';
import 'package:stone_recipe_app/models/recipe.dart';
import 'package:stone_recipe_app/services/db_services.dart';
import 'package:stone_recipe_app/subscategory.dart';
import 'package:stone_recipe_app/widgets/customdrawers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbservice = DataBaseService();

  @override
  void dispose() {
    dbservice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Recipe App',
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: const Color(0xffBDDA9B),
          iconTheme: const IconThemeData(color: Color(0xffBF8054)),
          // backgrouDndColor: Color.fromARGB(0, 173, 221, 117),
        ),
        drawer: customDrawer(),
        body: Getdata());
  }

  Widget Getdata() {
    return FutureBuilder<List<RecipeCat>>(
        future: dbservice.getCategory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Container(
                        width: 400,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          image: DecorationImage(
                            image: AssetImage("Recipe/${snapshot.data![index].recipe_cat}.jpg"),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            snapshot.data![index].recipe_cat,
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
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
        });
    // return ListView.builder(
    //   shrinkWrap: true,
    //   itemCount: Cat.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return GestureDetector(
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => SubCategory(), settings: RouteSettings(arguments: Cat[index])),
    //           );
    //         },
    //         child: SingleChildScrollView(
    //           scrollDirection: Axis.vertical,
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    //                 child: Container(
    //                   width: 400,
    //                   height: 80,
    //                   decoration: const BoxDecoration(
    //                     borderRadius: BorderRadius.all(const Radius.circular(8.0)),
    //                     image: const DecorationImage(
    //                       image: AssetImage("images/cook.jpg"),
    //                       fit: BoxFit.cover,
    //                       alignment: Alignment.topCenter,
    //                     ),
    //                     boxShadow: [
    //                       BoxShadow(
    //                         blurRadius: 5,
    //                         color: Colors.black,
    //                       )
    //                     ],
    //                   ),
    //                   child: Center(
    //                     child: Text(
    //                       Cat[index],
    //                       style: const TextStyle(color: Colors.white, fontSize: 20),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               )
    //             ],
    //           ),
    //         ));
    //   },
    // );
  }
}

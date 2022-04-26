import 'package:flutter/material.dart';
import 'package:stone_recipe_app/subscategory.dart';
import 'package:stone_recipe_app/widgets/customdrawers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    List<String> Cat = ['chines', 'chine', 'Indian', 'italian', 'Italian Pizza', 'Rice Recipes', 'Baking and Desserts'];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: Cat.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubCategory(), settings: RouteSettings(arguments: Cat[index])),
              );
            },
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
                        borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                        image: DecorationImage(
                          image: AssetImage("Recipe/${Cat[index]}.jpg"),
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
                          Cat[index],
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
  }
}

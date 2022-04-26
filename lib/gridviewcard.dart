import 'package:flutter/material.dart';
import 'package:stone_recipe_app/services/db_services.dart';

class GridDetail extends StatefulWidget {
  const GridDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<GridDetail> createState() => _GridDetailState();
}

class _GridDetailState extends State<GridDetail> {
  late String title;
  late String subtitle;
  bool _isfavorite = true;

  List images = [
    "images/cook.jpg",
    "images/download.jpg",
    "images/cook.jpg",
    "images/cook.jpg",
    "images/download.jpg",
    "images/cook.jpg",
    "images/cook.jpg",
    "images/download.jpg",
    "images/cook.jpg",
    "images/cook.jpg",
    "images/download.jpg",
    "images/cook.jpg",
  ];
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Wrap(
          spacing: 6,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            const Text(
              'All Recipe',
              style: TextStyle(color: Color(0xff007AFF)),
            )
          ],
        ),
        iconTheme: const IconThemeData(color: Color(0xff007AFF)),
        title: const Center(
          child: Text('Pakistan Recipe', style: TextStyle(color: Colors.black)),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('images/backimg.jpg'), fit: BoxFit.cover),
        ),
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return myItem(index);
          },
        ),
      ),
    );
  }

  Widget myItem(index) {
    return Column(
      children: [
        containertopPortion(index),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                textPortion('Backed Chicken Parcel'),
                textPortion('Chinese Recipes'),
              ],
            ),
            _isfavorite
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isfavorite = false;
                      });
                    },
                    icon: const Icon(Icons.favorite_border))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _isfavorite = true;
                      });
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ))
          ],
        )
      ],
    );
  }

  Widget textPortion(
    String title,
  ) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 65, 58, 58),
      ),
    );
  }

  Widget containertopPortion(index) {
    return Expanded(
      child: GestureDetector(
        onTap: (() => Navigator.pushNamed(context, '/details')),
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              image: DecorationImage(
                image: AssetImage(images[index]),
                fit: BoxFit.cover,
              ),
              boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black)]),
        ),
      ),
    );
  }
}

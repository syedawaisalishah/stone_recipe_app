import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:stone_recipe_app/models/recipe.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:stone_recipe_app/pdf/pdfgenerator/pdfapi.dart';

import 'favoritepage.dart';

class DetailedScreen extends StatelessWidget {
  DetailedScreen({Key? key, required this.recipe, required this.index}) : super(key: key);
  List<Recipe>? recipe;
  int index;

  @override
  Widget build(BuildContext context) {
    List recipes = [recipe![index].recipe_name, recipe![index].recipe_ingrdients, recipe![index].recipe_prep];
    pdfcreation() async {
      final doc = pw.Document();

      doc.addPage(pw.Page(
          build: (pw.Context context) {
            return pw.Center(
                child: pw.Column(children: [
              pw.Center(
                child: pw.Text(
                  recipe![index].recipe_name,
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Center(
                    child: pw.Text(
                      'Ingredients',
                      style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Column(
                    children: [
                      pw.Text(
                        recipe![index].recipe_ingrdients,
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  pw.Center(
                    child: pw.Text(
                      'Method',
                      style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Text(
                    recipe![index].recipe_prep,
                    style: pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ]));
          },
          pageFormat: PdfPageFormat.a4));

      await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff007AFF)),
        title: Center(
          child: Text(
            recipe![index].recipe_name,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200),
              ),
              child: Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  image: DecorationImage(
                    image: AssetImage('Recipe/${recipe![index].image_name}.jpg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                  icon: Icon(
                    Icons.print_outlined,
                    size: 30,
                  ),
                  onPressed: () {
                    pdfcreation();
                  }),
              IconButton(
                  onPressed: () {
                    Share.share(recipes.toString());
                  },
                  icon: const Icon(
                    Icons.share,
                    color: Colors.blue,
                    size: 30,
                  )),
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
              )
            ]),
            SizedBox(
              height: 1000,
              child: Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Ingredients',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: [
                        Text(recipe![index].recipe_ingrdients),
                      ],
                    ),
                    const Center(
                      child: Text(
                        'Method',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      recipe![index].recipe_prep,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

    // Scaffold(
    //   appBar: AppBar(
    //     title: Text(recipe![index].recipe_name),
    //   ),
    //   body: Center(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           SelectableText(recipe![index].recipe_cat),
    //           Text(recipe![index].recipe_prep),
    //           Text(recipe![index].recipe_id.toString()),
    //           Text(recipe![index].recipe_ingrdients),
    //           Text(recipe![index].image_name),
    //           OutlinedButton(
    //               onPressed: () {
    //                 Share.share(recipe![index].recipe_prep);
    //               },
    //               child: Text('Share'))
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

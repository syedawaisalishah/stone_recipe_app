import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import 'package:stone_recipe_app/models/recipe.dart';
import 'package:stone_recipe_app/services/db_services.dart';
import 'package:pdf/widgets.dart' as pw;

import 'favoritepage.dart';

class Favoritedetailpage extends StatefulWidget {
  var title;

  Favoritedetailpage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Favoritedetailpage> createState() => _FavoritedetailpageState();
}

class _FavoritedetailpageState extends State<Favoritedetailpage> {
  final dbservice = DataBaseService();

  @override
  void dispose() {
    dbservice.dispose();
    super.dispose();
  }

  var name;
  @override
  Widget build(BuildContext context) {
    // List recipes = [recipe![index].recipe_name, recipe![index].recipe_ingrdients, recipe![index].recipe_prep];
    // pdfcreation() async {
    //   final doc = pw.Document();

    //   doc.addPage(pw.Page(
    //       build: (pw.Context context) {
    //         return pw.Center(
    //             child: pw.Column(children: [
    //           pw.Center(
    //             child: pw.Text(
    //               recipe![index].recipe_name,
    //               style: pw.TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: pw.FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //           pw.SizedBox(height: 10),
    //           pw.Column(
    //             crossAxisAlignment: pw.CrossAxisAlignment.start,
    //             children: [
    //               pw.Center(
    //                 child: pw.Text(
    //                   'Ingredients',
    //                   style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
    //                 ),
    //               ),
    //               pw.Column(
    //                 children: [
    //                   pw.Text(
    //                     recipe![index].recipe_ingrdients,
    //                     style: pw.TextStyle(
    //                       fontSize: 16,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               pw.Center(
    //                 child: pw.Text(
    //                   'Method',
    //                   style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
    //                 ),
    //               ),
    //               pw.Text(
    //                 recipe![index].recipe_prep,
    //                 style: pw.TextStyle(
    //                   fontSize: 16,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ]));
    //       },
    //       pageFormat: PdfPageFormat.a4));

    //   await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());
    // }

    var id = ModalRoute.of(context)!.settings.arguments.toString();
    int ids = int.parse(id);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff007AFF)),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Recipe>>(
          future: dbservice.getid(ids),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                name = snapshot.data![index].recipe_name;
                return SingleChildScrollView(
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
                              image: AssetImage('Recipe/${snapshot.data![index].image_name}.jpg'),
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
                        // const Icon(
                        //   Icons.file_download_sharp,
                        //   color: Colors.blue,
                        //   size: 30,
                        // ),
                        IconButton(
                            icon: Icon(
                              Icons.print_outlined,
                              size: 30,
                            ),
                            onPressed: () async {
                              final doc = pw.Document();

                              doc.addPage(pw.Page(
                                  build: (pw.Context context) {
                                    return pw.Center(
                                        child: pw.Column(children: [
                                      pw.Center(
                                        child: pw.Text(
                                          snapshot.data![index].recipe_name,
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
                                                snapshot.data![index].recipe_ingrdients,
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
                                            snapshot.data![index].recipe_prep,
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
                            }),
                        IconButton(
                            onPressed: () {
                               List recipes = [snapshot.data![index].recipe_name, snapshot.data![index].recipe_ingrdients, snapshot.data![index].recipe_prep];
                              Share.share(recipes.toString());
                            },
                            icon: const Icon(
                              Icons.share,
                              color: Colors.blue,
                              size: 30,
                            )),
                        IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Favorite()),
                              );
                            })
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
                                  Text(snapshot.data![index].recipe_ingrdients),
                                ],
                              ),
                              const Center(
                                child: Text(
                                  'Method',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                snapshot.data![index].recipe_prep,
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
                );
              },
            );
          }),
    );
  }
}

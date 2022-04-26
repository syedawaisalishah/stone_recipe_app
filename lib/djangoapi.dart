// import 'dart:convert';
// import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class DjangoApi extends StatefulWidget {
//   const DjangoApi({Key? key}) : super(key: key);

//   @override
//   State<DjangoApi> createState() => _DjangoApiState();
// }

// class _DjangoApiState extends State<DjangoApi> {
//   StudentData _studentData = StudentData();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       child: FutureBuilder<List<dynamic>>(
//         future: _studentData.getallstudent(),
//         builder: (context, snapshot) {
//           print(snapshot.data);
//           if (snapshot.hasData) {
//             return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                       child: ListTile(
//                     title: Text('name'),
//                     subtitle: Text('city'),
//                   ));
//                 });
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     ));
//   }
// }

// class StudentData {
//   String Urls = 'http://127.0.0.1:8000/studinfo/';
//   Future<List<dynamic>> getallstudent() async {
//     try {
//       // var Response = await http.get();
//       if (Response.statusCode == 200) {
//         return jsonDecode(Response.body);
//       } else {
//         return Future.error('server error');
//       }
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
// }

// ignore_for_file: file_names
// ignore: 
// // ignore_for_file: file_names, camel_case_types

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class getYearDegree extends StatelessWidget {
//   final String documentId;
//   const getYearDegree({
//     super.key,
//     required this.documentId,
//   });

//   @override
//   Widget build(BuildContext context) {
// // get the collection

//     CollectionReference degree =
//         FirebaseFirestore.instance.collection('Degree');

//     return FutureBuilder<DocumentSnapshot>(
//         future: degree.doc(documentId).get(),
//         builder: ((context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic> data =
//                 snapshot.data!.data() as Map<String, dynamic>;
//             //  print(data);
//             return Text(
//               '  ${data['Year']}',
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
//             );
//           }
//           return const CircularProgressIndicator();
//         }));
//   }
// }

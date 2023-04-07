// ignore_for_file: file_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class getYearDiploma extends StatelessWidget {
  final String documentId;
  const getYearDiploma({
    super.key,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
// get the collection

    CollectionReference diploma = FirebaseFirestore.instance.collection('Diploma');

    return FutureBuilder<DocumentSnapshot>(
        future: diploma.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Center(
              child: Text(
                '${data['Year']}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            );
          }
          return const CircularProgressIndicator();
        }));
  }
}

// ignore_for_file: unused_import, camel_case_types, prefer_const_constructors, file_names, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/diploma/getYearDiploma.dart';

class allYearDiploma extends StatefulWidget {
  const allYearDiploma({super.key});

  @override
  State<allYearDiploma> createState() => _allYearDiplomaState();
}

class _allYearDiplomaState extends State<allYearDiploma> {
  //  document Ids
  List<String> docIds = [];

  // get DocIds

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Diploma').orderBy('rank' , descending: false)
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((snapshot) => snapshot.docs.forEach((document) {
              docIds.add(document.reference.id);
            }));
  }
     

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text("DIPLOMA",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontStyle: FontStyle.italic)),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: FutureBuilder(
              future: getDocId(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: docIds.length, 
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListTile(
                          title: (getYearDiploma(documentId: docIds[index])),
                          tileColor: Color.fromARGB(255, 93, 198, 240),
                        ),
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}

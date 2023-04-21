// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: unused_import, camel_case_types, prefer_const_constructors, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_function_literals_in_foreach_calls, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/departments.dart';
import 'package:vjti_previous/degree/getYearDegree.dart';
import 'package:vjti_previous/utilities/routes.dart';

class allYearDegree extends StatefulWidget {
  const allYearDegree({super.key});

  @override
  State<allYearDegree> createState() => _allYearDegreeState();
}

class _allYearDegreeState extends State<allYearDegree> {
  // final firestore = FirebaseFirestore.instance.collection("Degree").snapshots();

  //  document Ids
  List<String> docIds = [];

  // get DocIds

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Degree')
        .orderBy('rank', descending: false)
        .get()
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
        title: Text("DEGREE",
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
                        child: InkWell(
                          onTap: () {
                            // print(docIds[index]);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return 
                              //Test();
                             departments(
                                dept: docIds[index] , degreeId:docIds[index],
                              );
                            }));
                          },
                          child: Card(
                            color: Colors.indigo,
                            child: (getYearDegree(documentId: docIds[index])),
                          ),
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

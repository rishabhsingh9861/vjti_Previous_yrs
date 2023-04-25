// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: unused_import, camel_case_types, prefer_const_constructors, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_function_literals_in_foreach_calls, file_names

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/departments.dart';
import 'package:vjti_previous/degree/getYearDegree.dart';
import 'package:vjti_previous/diploma/fy_Subdepartments.dart';
import 'package:vjti_previous/utilities/routes.dart';

class allYearDiploma extends StatefulWidget {
  const allYearDiploma({super.key});

  @override
  State<allYearDiploma> createState() => _allYearDiplomaState();
}

class _allYearDiplomaState extends State<allYearDiploma> {
  // final firestore = FirebaseFirestore.instance.collection("Degree").snapshots();

  //  document Ids
  List<String> diplomadocIds = [];
  List<String> diplomadocdata = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Diploma')
            .orderBy('rank', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Diploma',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    diplomadocIds.add(snapshot.data!.docs[index].id);
                    final data = snapshot.data!.docs[index].data();

                    String yrs = '${data['Year']}';
                    diplomadocdata.add(yrs);
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return diplomadepartments(
                              diplomadept: diplomadocIds[index],
                              diplomaId: diplomadocIds[index],
                              diplomadata: diplomadocdata[index],
                            );
                          }));
                        },
                        child: Container(
                          height: 50,
                          width: 160,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 149, 223, 225),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            child: Text(
                              yrs,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}

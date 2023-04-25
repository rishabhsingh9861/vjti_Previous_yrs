// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/fy_mst.dart';
import 'package:vjti_previous/degree/sytyfy_semester.dart';
import 'package:vjti_previous/diploma/diplomafymst.dart';
import 'package:vjti_previous/diploma/sytydiplomasemester.dart';

class diplomadepartments extends StatefulWidget {
  diplomadepartments(
      {super.key, this.diplomadept, this.diplomaId, this.diplomadata});
  String? diplomadept;
  String? diplomaId;
  String? diplomadata;

  @override
  State<diplomadepartments> createState() => _diplomadepartmentsState();
}

class _diplomadepartmentsState extends State<diplomadepartments> {
  late CollectionReference reference;
  List<String> diplomasub = [];
  List<String> diplomapriya = [];
  List<String> diplomadepartmentname = [];

  @override
  void initState() {
    if (widget.diplomadept == "FirstYear") {
      reference = FirebaseFirestore.instance
          .collection("Diploma")
          .doc(widget.diplomadept)
          .collection("Subjects");
    } else {
      reference = FirebaseFirestore.instance
          .collection("Diploma")
          .doc(widget.diplomadept)
          .collection("Departments");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: reference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Diploma' ' ${[widget.diplomadata]}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    )),
              ),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    diplomasub.add(snapshot.data!.docs[index].id); // subject id
                    final getdata = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    if (widget.diplomadept == "FirstYear") {
                      String rishabhdiploma = '  ${getdata['Subject']}';

                      diplomapriya.add(rishabhdiploma); // subject data

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return DiplomaFyPaper(
                                diplomasubid: diplomasub[index],
                              );
                            }));
                          },
                          child: Container(
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 149, 223, 225),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                rishabhdiploma,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      String ankit = snapshot.data!.docs[index].id;
                      String rishabh = '  ${getdata['Dept']}';
                      diplomapriya.add(ankit);
                      diplomadepartmentname.add(rishabh);

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            //  print(pankaj);
                            //  print(priya);
                            // print(snapshot.data!.docs[index].data()["Subject"]);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return DiplomaSyFySemester(
                                  diplomadepartname: diplomadepartmentname[index],
                                  diplomadepartId: diplomapriya[index],
                                  diplomadegreeIds: widget.diplomadept);
                            }));
                          },
                          child: Container(
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 149, 223, 225),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                rishabh,

                                // priya.toString() ,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
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

// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/fy_mst.dart';
import 'package:vjti_previous/degree/sytyfy_semester.dart';

class departments extends StatefulWidget {
  departments({super.key, this.dept, this.degreeId, this.degreedata});
  String? dept;
  String? degreeId;
  String? degreedata;

  @override
  State<departments> createState() => _departmentsState();
}

class _departmentsState extends State<departments> {
  late CollectionReference reference;
  List<String> sub = [];
  List<String> priya = [];
  List<String> departmentname = [];

  @override
  void initState() {
    if (widget.dept == "FirstYear") {
      reference = FirebaseFirestore.instance
          .collection("Degree")
          .doc(widget.dept)
          .collection("Subjects");
    } else {
      reference = FirebaseFirestore.instance
          .collection("Degree")
          .doc(widget.dept)
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
                title: Text('Degree' ' ${[widget.degreedata]}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    )),
              ),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    sub.add(snapshot.data!.docs[index].id); // subject id
                    final getdata = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    if (widget.dept == "FirstYear") {
                      String rishabh = '  ${getdata['Subject']}';

                      priya.add(rishabh); // subject data

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return FyPaper(
                                subid: sub[index],
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
                                rishabh,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      String ankit = snapshot.data!.docs[index].id;
                      String rishabh = '  ${getdata['Dept']}';
                      priya.add(ankit);
                      departmentname.add(rishabh);

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            //  print(pankaj);
                            //  print(priya);
                            // print(snapshot.data!.docs[index].data()["Subject"]);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return SyTyFySemester(
                                departname: departmentname[index],
                                departId: priya[index],
                                degreeIds: widget.dept, // year list is there
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

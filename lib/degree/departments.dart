// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/fypaper.dart';
import 'package:vjti_previous/degree/subject.dart';

class departments extends StatefulWidget {
  departments({super.key, this.dept, this.degreeId});
  String? dept;
  String? degreeId;

  @override
  State<departments> createState() => _departmentsState();
}

class _departmentsState extends State<departments> {
  late CollectionReference reference;
  List<String> sub = [];
  List<String> priya = [];

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
              backgroundColor: Colors.black,
              appBar: AppBar(
                title: Text('Degree' ' ${[widget.dept]}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontStyle: FontStyle.italic)),
              ),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    sub.add(snapshot.data!.docs[index].id); // subject id
                    final getdata = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    if (widget.dept == "FirstYear") {
                      String rishabh = '${getdata['Subject']}';

                      priya.add(rishabh); // subject data

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                             // print(sub);
                              //print(priya);
                              return FyPaper(
                                subid: sub[index],
                              );
                            }));
                          },
                          child: Card(
                            color: const Color.fromARGB(255, 66, 90, 228),
                            child: Text(
                              rishabh,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ),
                      );
                    } else {
                      String rishabh = '${getdata['Dept']}';
                      priya.add(rishabh);

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            //  print(pankaj);
                            //  print(priya);
                            // print(snapshot.data!.docs[index].data()["Subject"]);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return DeptSubjects(
                                departId: priya[index],
                                degreeIds: widget.dept,
                              );
                            }));
                          },
                          child: Card(
                            color: Colors.indigo,
                            child: Text(
                              rishabh,

                              // priya.toString() ,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
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

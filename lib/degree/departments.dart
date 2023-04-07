
// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class departments extends StatefulWidget {
  departments({super.key, this.dept});
  String? dept;

  @override
  State<departments> createState() => _departmentsState();
}

class _departmentsState extends State<departments> {
  bool loading = false;

  late CollectionReference reference;

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
                title: const Text('Degree',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontStyle: FontStyle.italic)),
              ),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String dept = snapshot.data!.docs[index].id;
                    

                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          // print(snapshot.data!.docs[index].data()["Subject"]);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) {
                          //   return departments(
                          //     name: docIds[index],
                          //   );
                          // }));
                        },
                        child: Card(
                          color: Colors.indigo,
                          child: Text(
                            dept,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Scaffold(
              body: CircularProgressIndicator(),
            );
          }
        });
  }
}

class getDepartments extends StatelessWidget {
  getDepartments({
    Key? key,
    // required this.documentId,
    this.deptId,
  }) : super(key: key);

  final String? deptId;
// final String documentId;
  late  CollectionReference dept;

  @override
  Widget build(BuildContext context) {
    if (deptId == "FirstYear") {
      dept = FirebaseFirestore.instance
          .collection('Degree')
          .doc(deptId)
          .collection('Subjects');

      return FutureBuilder<DocumentSnapshot>(
          future: dept.doc(deptId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Text(
                '${(data['Subject'])}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              );
            }

            return const CircularProgressIndicator();
          });
    } else {
      dept = FirebaseFirestore.instance
          .collection('Degree')
          .doc(deptId)
          .collection('Departments');

      return FutureBuilder<DocumentSnapshot>(
          future: dept.doc(deptId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Text(
                '${(data['Departments'])}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              );
            }

            return const CircularProgressIndicator();
          });
    }

    // return FutureBuilder<DocumentSnapshot>(
    //   future: dept.doc(documentId).get() ,
    //   builder: (context , snapshot ){
    //     if(snapshot.connectionState == ConnectionState.done) {
    //       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>
    //       return Text('${(data['Subject'])}');
    //     }

    //     return CircularProgressIndicator();
    //   } );
  }
}
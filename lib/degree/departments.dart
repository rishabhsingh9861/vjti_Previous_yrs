// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/fypaper.dart';

class departments extends StatefulWidget {
  departments({super.key, this.dept});
  String? dept;

  @override
  State<departments> createState() => _departmentsState();
}

class _departmentsState extends State<departments> {
  bool loading = false;

  late CollectionReference reference;
  List<String> sub = [];

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
                    sub.add(snapshot.data!.docs[index].id);
                    final getdata = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    if (widget.dept == "FirstYear") {
                      String rishabh = '${getdata['Subject']}';
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            //  print(priya);
                            // print(snapshot.data!.docs[index].data()["Subject"]);
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (_) {
                            //   return departments(
                            //     name: docIds[index],
                            //   );
                            // }));
                          },
                          child: Card(
                            color: Color.fromARGB(255, 66, 90, 228),
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

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            //  print(priya);
                            // print(snapshot.data!.docs[index].data()["Subject"]);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return FyPaper(
                                subid: sub[index],
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
              body: CircularProgressIndicator(),
            );
          }
        });
  }
}

class getDepartments {
  getDepartments({
    Key? key,
    // required this.documentId,
    // this.deptId,
  });

  String? deptId;
// final String documentId;
  late CollectionReference dept;

  Future Subjects() async {
    await for (var rishabh
        in FirebaseFirestore.instance.collection('Degree').snapshots()) {
      for (var rish in rishabh.docs) {
        //  print(rish.data());
        final pranjan = rish.id;
        final ankit = pranjan.toString();
        deptId = ankit;
        //     print(rohit);
        //     // return rohit;
        //     if (rohit == "FirstYear") {
        //        FirebaseFirestore.instance
        //           .collection('Degree')
        //           .doc('FirstYear')
        //           .collection('Subjects');

        //     } else {
        //  final   titan =  FirebaseFirestore.instance
        //           .collection('Degree')
        //           .doc(rohit)
        //           .collection('Departments');
        //              print(titan);
        //     }
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  );
                }

                return const CircularProgressIndicator();
              });
        }
      }
    }
  }

  // if (deptId == "FirstYear") {
  //   dept = FirebaseFirestore.instance
  //       .collection('Degree')
  //       .doc(deptId)
  //       .collection('Subjects');

  //   return FutureBuilder<DocumentSnapshot>(
  //       future: dept.doc(deptId).get(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           Map<String, dynamic> data =
  //               snapshot.data!.data() as Map<String, dynamic>;
  //           return Text(
  //             '${(data['Subject'])}',
  //             style:
  //                 const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
  //           );
  //         }

  //         return const CircularProgressIndicator();
  //       });
  // } else {
  //   dept = FirebaseFirestore.instance
  //       .collection('Degree')
  //       .doc(deptId)
  //       .collection('Departments');

  //   return FutureBuilder<DocumentSnapshot>(
  //       future: dept.doc(deptId).get(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           Map<String, dynamic> data =
  //               snapshot.data!.data() as Map<String, dynamic>;
  //           return Text(
  //             '${(data['Departments'])}',
  //             style:
  //                 const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
  //           );
  //         }

  //         return const CircularProgressIndicator();
  //       });
  // }

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

// void Subjects() async {
//   await for (var rishabh
//       in FirebaseFirestore.instance.collection('Degree').snapshots()) {
//     for (var rish in rishabh.docs) {
//       //  print(rish.data());
//       final pranjan = rish.id;
//       final ankit = pranjan.toString();
//       rohit = ankit;
//       print(rohit);
//       // return rohit;
//       if (rohit == "FirstYear") {
//         FirebaseFirestore.instance
//             .collection('Degree')
//             .doc('FirstYear')
//             .collection('Subjects');
//       } else {
//         final titan = FirebaseFirestore.instance
//             .collection('Degree')
//             .doc(rohit)
//             .collection('Departments');
//         print(titan);
//       }
//     }
//   }
// }

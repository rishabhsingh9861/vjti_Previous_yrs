import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/departments.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  // String? rohit;
  List<String> rohit = [];
  List<String> tuntun = [];
  CollectionReference? reference;

  @override
  void initState() {
    subjects().toString();
    for (var d in rohit) {
      // print(d);

      if (d == "FirstYear") {
        reference = FirebaseFirestore.instance
            .collection('Degree')
            .doc(d)
            .collection('Subjects');
      } else {
        reference = FirebaseFirestore.instance
            .collection('Degree')
            .doc(d)
            .collection('Departments');
      }
    }

    super.initState();
  }

  Future subjects() async {
    final degree = FirebaseFirestore.instance.collection('Degree').snapshots();
    await for (var a in degree) {
      for (var b in a.docs) {
        final c = b.id;
        rohit.add(c);
        // return rohit;
      }
    }
  }

  // Future sub() async {
  //   for (var d in rohit) {
  //     // print(d);

  //     if (d == "FirstYear") {
  //   ridhima =  FirebaseFirestore.instance.collection('Degree').doc(d).collection('Subjects');

  //       }
  //     else {
  //      ridhima = FirebaseFirestore.instance.collection('Degree').doc(d).collection('Departments');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: reference?.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final dept = snapshot.data!.docs;
            List<Text> depart = [];
            for (var g in dept) {
             final h = g.id;
              tuntun.add(h);
            }
          }
          return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                title: const Text('Degree',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontStyle: FontStyle.italic)),
              ),
              body: Center(
                child: ElevatedButton(
                  child: const Text('Test'),
                  onPressed: () {
                    print(tuntun);
                    //  print(panakj);
                    // print(rohit);
                    // print(rohit);
                    // sub();
                  },
                ),
              ));
        });

    //  Scaffold(
    //     backgroundColor: Colors.black,
    //     appBar: AppBar(
    //       title: const Text('Degree',
    //           style: TextStyle(
    //               fontWeight: FontWeight.bold,
    //               fontSize: 30,
    //               fontStyle: FontStyle.italic)),
    //     ),
    //     body: Column(
    //       children: [

    //         Center(
    //           child: ElevatedButton(
    //             child: const Text('Test'),
    //             onPressed: () {
    //               //  print(panakj);
    //               // print(rohit);
    //               // print(rohit);
    //               // sub();
    //             },
    //           ),
    //         ),
    //       ],
    //     ));
  }
}

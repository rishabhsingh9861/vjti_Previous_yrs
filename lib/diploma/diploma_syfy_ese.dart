// here we are viewing mst paper of first year

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/viewfymst.dart';

class DiplomaSyFyEsePaper extends StatefulWidget {
  const DiplomaSyFyEsePaper(
      {super.key,
      this.diplomasubjectid,
      this.diplomayearsids,
      this.diplomadepartsids,
      this.diplomasemestids});
  final String? diplomasubjectid;
  final String? diplomayearsids;
  final String? diplomadepartsids;
  final String? diplomasemestids;
  // final String? msturl;
  // final String? eseurl; /Degree/SecondYear/Departments/Cs/Semesters/sem3/Subjects/dbms/mst/dbms2

  @override
  State<DiplomaSyFyEsePaper> createState() => _DiplomaSyFyEsePaperState();
}

class _DiplomaSyFyEsePaperState extends State<DiplomaSyFyEsePaper> {
  List<String> diplomapdfurlsy = [];
  List<String> diplomayearsy = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Diploma')
          .doc(widget.diplomayearsids)
          .collection('Departments')
          .doc(widget.diplomadepartsids)
          .collection('Semesters')
          .doc(widget.diplomasemestids)
          .collection('Subjects')
          .doc(widget.diplomasubjectid)
          .collection('mst')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'ESE',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontStyle: FontStyle.italic),
              ),
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String diplomamstsyid =
                    snapshot.data!.docs[index].id; // sy ty fy ids here

                final diplomamstsy =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                String diplomaurlsy = '${diplomamstsy['url']}';
                String diplomapaperyearsy = '${diplomamstsy['year']}';
                diplomapdfurlsy.add(diplomaurlsy);
                diplomayearsy.add(diplomapaperyearsy);

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ViewFyMst(
                          pdfurl: diplomapdfurlsy[index],
                          paperyear: diplomayearsy[index],
                        );
                      }));
                    },
                    child: Container(
                        height: 40,
                        width: 250,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 149, 223, 225),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                diplomapaperyearsy,
                                style: const TextStyle(
                                    // color: Colors.white,

                                    fontSize: 24),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.picture_as_pdf,
                                color: Color.fromARGB(255, 13, 9, 9),
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
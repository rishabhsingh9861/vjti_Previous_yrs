// here we are viewing mst paper of first year

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/viewfymst.dart';

class SyTyFyEsePaper extends StatefulWidget {
  const SyTyFyEsePaper(
      {super.key,
      this.subjectid,
      this.yearsids,
      this.departsids,
      this.semestids});
  final String? subjectid;
  final String? yearsids;
  final String? departsids;
  final String? semestids;
  // final String? msturl;
  // final String? eseurl; /Degree/SecondYear/Departments/Cs/Semesters/sem3/Subjects/dbms/mst/dbms2

  @override
  State<SyTyFyEsePaper> createState() => _SyTyFyEsePaperState();
}

class _SyTyFyEsePaperState extends State<SyTyFyEsePaper> {
  List<String> pdfurlsy = [];
  List<String> yearsy = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Degree')
          .doc(widget.yearsids)
          .collection('Departments')
          .doc(widget.departsids)
          .collection('Semesters')
          .doc(widget.semestids)
          .collection('Subjects')
          .doc(widget.subjectid)
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
                    ),
              ),
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {


                final mstsy =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                String urlsy = '${mstsy['url']}';
                String paperyearsy = '${mstsy['year']}';
                pdfurlsy.add(urlsy);
                yearsy.add(paperyearsy);

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ViewFyMst(
                          pdfurl: pdfurlsy[index],
                          paperyear: yearsy[index],
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
                                paperyearsy,
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

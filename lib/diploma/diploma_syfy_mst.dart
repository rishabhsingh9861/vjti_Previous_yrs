// here we are viewing mst paper of first year

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/viewfymst.dart';
import 'package:vjti_previous/diploma/diploma_syfy_ese.dart';

class DiplomaSyTyFyMstPaper extends StatefulWidget {
  const DiplomaSyTyFyMstPaper(
      {super.key,
      this.diplomasubjecid,
      this.diplomayearids,
      this.diplomadepartids,
      this.diplomasemestid});
  final String? diplomasubjecid;
  final String? diplomayearids;
  final String? diplomadepartids;
  final String? diplomasemestid;
  // final String? msturl;
  // final String? eseurl; /Degree/SecondYear/Departments/Cs/Semesters/sem3/Subjects/dbms/mst/dbms2

  @override
  State<DiplomaSyTyFyMstPaper> createState() => _DiplomaSyTyFyMstPaperState();
}

class _DiplomaSyTyFyMstPaperState extends State<DiplomaSyTyFyMstPaper> {
  List<String> diplomapdfurlsy = [];
  List<String> diplomayearsy = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Diploma')
          .doc(widget.diplomayearids)
          .collection('Departments')
          .doc(widget.diplomadepartids)
          .collection('Semesters')
          .doc(widget.diplomasemestid)
          .collection('Subjects')
          .doc(widget.diplomasubjecid)
          .collection('mst')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'MST',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              actions: [
                const Icon(
                  Icons.arrow_forward,
                  size: 26,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DiplomaSyFyEsePaper(
                          diplomayearsids: widget.diplomayearids,
                          diplomadepartsids: widget.diplomadepartids,
                          diplomasemestids: widget.diplomasemestid,
                          diplomasubjectid: widget.diplomasubjecid,
                        );
                      }));
                    },
                    child: const Text("ESE",
                        style: TextStyle(
                          color: Color.fromARGB(255, 205, 240, 103),
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        )))
              ],
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
// sy ty fy ids here

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
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  diplomapaperyearsy,
                                  style: const TextStyle(
                                      // color: Colors.white,

                                      fontSize: 24),
                                ),
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

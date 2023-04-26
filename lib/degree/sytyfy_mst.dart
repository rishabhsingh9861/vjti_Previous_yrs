// here we are viewing mst paper of first year

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/sytyfy_ese.dart';
import 'package:vjti_previous/degree/viewfymst.dart';

class SyTyFyMstPaper extends StatefulWidget {
  const SyTyFyMstPaper(
      {super.key, this.subjecid, this.yearids, this.departids, this.semestid});
  final String? subjecid;
  final String? yearids;
  final String? departids;
  final String? semestid;
  // final String? msturl;
  // final String? eseurl; /Degree/SecondYear/Departments/Cs/Semesters/sem3/Subjects/dbms/mst/dbms2

  @override
  State<SyTyFyMstPaper> createState() => _SyTyFyMstPaperState();
}

class _SyTyFyMstPaperState extends State<SyTyFyMstPaper> {
  List<String> pdfurlsy = [];
  List<String> yearsy = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Degree')
          .doc(widget.yearids)
          .collection('Departments')
          .doc(widget.departids)
          .collection('Semesters')
          .doc(widget.semestid)
          .collection('Subjects')
          .doc(widget.subjecid)
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
                        return SyTyFyEsePaper(
                          yearsids: widget.yearids,
                          departsids: widget.departids,
                          semestids: widget.semestid,
                          subjectid: widget.subjecid,
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
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  paperyearsy,
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

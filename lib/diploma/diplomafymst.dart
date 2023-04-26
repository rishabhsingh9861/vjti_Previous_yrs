// here we are viewing mst paper of first year

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/fy_ese.dart';
import 'package:vjti_previous/degree/viewfymst.dart';
import 'package:vjti_previous/diploma/diplomafyese.dart';

class DiplomaFyPaper extends StatefulWidget {
  const DiplomaFyPaper({super.key, this.diplomasubid});
  final String? diplomasubid;
  // final String? msturl;
  // final String? eseurl;

  @override
  State<DiplomaFyPaper> createState() => _DiplomaFyPaperState();
}

class _DiplomaFyPaperState extends State<DiplomaFyPaper> {
  List<String> diplomapdfurl = [];
  List<String> diplomayear = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Diploma')
          .doc('FirstYear')
          .collection('Subjects')
          .doc(widget.diplomasubid)
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
                  fontSize: 26,
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
                        return DiplomaFyPaperEse(
                          diplomasubid: widget.diplomasubid,
                        );
                      }));
                    },
                    child: const Text("ESE",
                        style: TextStyle(
                          color: Color.fromARGB(255, 217, 233, 92),
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        )))
              ],
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String a = snapshot.data!.docs[index].id;

                final diplomamstpaper =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                String diplomaurl = '${diplomamstpaper['url']}';
                String diplomapaperyear = '  ${diplomamstpaper['year']}';
                diplomapdfurl.add(diplomaurl);
                diplomayear.add(diplomapaperyear);

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ViewFyMst(
                          pdfurl: diplomapdfurl[index],
                          paperyear: diplomayear[index],
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
                            child: Text(
                              diplomapaperyear,
                              style: const TextStyle(
                                  // color: Colors.white,
                                  // fontWeight: FontWeight.bold,
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
                      ),
                    ),
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

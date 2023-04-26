// here we are viewing mst paper of first year

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/fy_ese.dart';
import 'package:vjti_previous/degree/viewfymst.dart';

class FyPaper extends StatefulWidget {
  const FyPaper({super.key, this.subid});
  final String? subid;
  // final String? msturl;
  // final String? eseurl;

  @override
  State<FyPaper> createState() => _FyPaperState();
}

class _FyPaperState extends State<FyPaper> {
  List<String> pdfurl = [];
  List<String> year = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Degree')
          .doc('FirstYear')
          .collection('Subjects')
          .doc(widget.subid)
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
                        return FyPaperEse(
                          subid: widget.subid,
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

                final mstpaper =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                String url = '${mstpaper['url']}';
                String paperyear = '  ${mstpaper['year']}';
                pdfurl.add(url);
                year.add(paperyear);

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ViewFyMst(
                          pdfurl: pdfurl[index],
                          paperyear: year[index],
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
                              paperyear,
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

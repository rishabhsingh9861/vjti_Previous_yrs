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
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: const Center(
                child: Text(
                  'MST',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontStyle: FontStyle.italic),
                ),
              ),
              actions: [
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
                            fontSize: 30,
                            fontStyle: FontStyle.italic)))
              ],
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String _a = snapshot.data!.docs[index].id;

                final _mstpaper =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                String _url = '${_mstpaper['url']}';
                String _paperyear = '${_mstpaper['year']}';
                pdfurl.add(_url);
                year.add(_paperyear);

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
                    child: Card(
                      color: const Color.fromARGB(255, 66, 90, 228),
                      child: Center(
                        child: Text(
                          _paperyear,
                          style: const TextStyle(
                              // color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
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

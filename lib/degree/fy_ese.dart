// ignore: file_names
// here we are viewing ese paper of first year



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/viewfymst.dart';

class FyPaperEse extends StatefulWidget {
  const FyPaperEse({super.key, this.subid});
  final String? subid;
  // final String? msturl;
  // final String? eseurl;

  @override
  State<FyPaperEse> createState() => _FyPaperEseState();
}

class _FyPaperEseState extends State<FyPaperEse> {
  final gsReference = FirebaseStorage.instance;
  List<String> pdfurl = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Degree')
          .doc('FirstYear')
          .collection('Subjects')
          .doc(widget.subid)
          .collection('ese')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: const Center(
                child: Text(
                  'ESE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontStyle: FontStyle.italic),
                ),
              ),
           
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String a = snapshot.data!.docs[index].id;

                final esepaper =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                String url = '${esepaper['url']}';
                String paperyear = '${esepaper['year']}';
                pdfurl.add(url);

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ViewFyMst(
                          pdfurl: pdfurl[index],
                        );
                      }));
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 66, 90, 228),
                      child: Center(
                        child: Text(
                          paperyear,
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

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
  List<String> pdfurlese = [];

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
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'ESE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String b = snapshot.data!.docs[index].id;

                final esepaper =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                String urlese = '${esepaper['url']}';
                String paperyear = '  ${esepaper['year']}';
                pdfurlese.add(urlese);

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ViewFyMst(
                          pdfurl: pdfurlese[index],
                        );
                      }));
                    },
                    child: Container(
                      height: 40,
                      width: 250,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 149, 223, 225),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          paperyear,
                          style: const TextStyle(
                              // color: Colors.white,

                              fontSize: 24),
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

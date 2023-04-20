import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeptSubjects extends StatefulWidget {
  const DeptSubjects({super.key, this.departId, this.degreeIds});
  final String? departId;
  final String? degreeIds;

  @override
  State<DeptSubjects> createState() => _DeptSubjectsState();
}

class _DeptSubjectsState extends State<DeptSubjects> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Degree')
            .doc(widget.degreeIds)
            .collection('Departments')
            .doc(widget.departId)
            .collection('Subjects')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                title: Text('${widget.departId}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontStyle: FontStyle.italic)),
              ),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String shashank = snapshot.data!.docs[index].id;

                    final ridhima = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    String rohit = '${ridhima['Subject']}';
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: InkWell(
                        onTap: () {},
                        child: Card(
                          color: const Color.fromARGB(255, 66, 90, 228),
                          child: Text(
                            // '${ridhima['Subject']}',
                            //  rohit,
                            rohit,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}

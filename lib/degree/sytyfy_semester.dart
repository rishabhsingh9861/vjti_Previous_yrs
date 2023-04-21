import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/sem_3subject.dart';

class SyTyFySemester extends StatefulWidget {
  const SyTyFySemester(
      {super.key, this.departId, this.degreeIds, this.departname});
  final String? departId;
  final String? degreeIds;
  final String? departname;

  @override
  State<SyTyFySemester> createState() => _SyTyFySemesterState();
}

class _SyTyFySemesterState extends State<SyTyFySemester> {
  List<String> semIds = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Degree')
            .doc(widget.degreeIds)
            .collection('Departments')
            .doc(widget.departId)
            .collection('Semesters')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                title: Text('${widget.departname}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontStyle: FontStyle.italic)),
              ),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String semid = snapshot.data!.docs[index].id;

                    final semester = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    String sem = '${semester['Semester']}';
                    semIds.add(semid);

                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(100),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Sem3Subject(
                                  departname: widget.departname,
                                  departId: widget.departId,
                                  yearIds: widget.degreeIds,
                                  semIds: semIds[index],
                                );
                              }));
                            },
                            child: Center(
                              child: Card(
                                color: const Color.fromARGB(255, 66, 90, 228),
                                child: Text(
                                  // '${ridhima['Subject']}',
                                  sem,

                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

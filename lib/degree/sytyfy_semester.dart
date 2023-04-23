import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/sem_subject.dart';

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
              appBar: AppBar(
                centerTitle: true,
                title: Text('${widget.departname}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    )),
              ),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String semid = snapshot.data!.docs[index].id;

                    final semester = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    String sem = '  ${semester['Semester']}';
                    semIds.add(semid);

                    return Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
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
                            child: Container(
                              height: 40,
                              width: 160,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 149, 223, 225),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  // '${ridhima['Subject']}',
                                  sem,

                                  style: const TextStyle(fontSize: 26),
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

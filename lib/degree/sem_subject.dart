import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/sytyfy_mst.dart';

class Sem3Subject extends StatefulWidget {
  const Sem3Subject(
      {super.key, this.departId, this.yearIds, this.semIds, this.departname});
  final String? departId; // contain department ids
  final String? yearIds; // contains year ids
  final String? semIds; // contin semester ids
  final String? departname; // contain department name

  @override
  State<Sem3Subject> createState() => _Sem3SubjectState();
}

class _Sem3SubjectState extends State<Sem3Subject> {
  List<String> subjectssem3 = []; // contains sem 3 subject not an ids
  List<String> subjectsem3ids = []; // contains sem3  subject ids
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Degree')
            .doc(widget.yearIds)
            .collection('Departments')
            .doc(widget.departId)
            .collection('Semesters')
            .doc(widget.semIds)
            .collection('Subjects')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('${widget.departname}' '(${widget.semIds})',
                    style: const TextStyle(
                      fontSize: 24,
                    )),
              ),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String subjectsem3id = snapshot.data!.docs[index].id;
                    subjectsem3ids.add(subjectsem3id);

                    final subjectsem3 = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    String sub = '  ${subjectsem3['Subject']}';
                    subjectssem3.add(sub);

                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SyTyFyMstPaper(
                              yearids: widget.yearIds,
                              departids: widget.departId,
                              semestid: widget.semIds,
                              subjecid: subjectsem3id,
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
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              sub,
                              style: const TextStyle(fontSize: 24),
                            ),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/diploma/diploma_syfy_mst.dart';

class DiplomaSem3Subject extends StatefulWidget {
  const DiplomaSem3Subject(
      {super.key,
      this.diplomadepartId,
      this.diplomayearIds,
      this.diplomasemIds,
      this.diplomadepartname});
  final String? diplomadepartId; // contain department ids
  final String? diplomayearIds; // contains year ids
  final String? diplomasemIds; // contin semester ids
  final String? diplomadepartname; // contain department name

  @override
  State<DiplomaSem3Subject> createState() => _DiplomaSem3SubjectState();
}

class _DiplomaSem3SubjectState extends State<DiplomaSem3Subject> {
  List<String> diplomasubjectssem3 = []; // contains sem 3 subject not an ids
  List<String> diplomasubjectsem3ids = []; // contains sem3  subject ids
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Diploma')
            .doc(widget.diplomayearIds)
            .collection('Departments')
            .doc(widget.diplomadepartId)
            .collection('Semesters')
            .doc(widget.diplomasemIds)
            .collection('Subjects')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('${widget.diplomadepartname}',
                    style: const TextStyle(
                      fontSize: 24,
                    )),
              ),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String subjectsem3id = snapshot.data!.docs[index].id;
                    diplomasubjectsem3ids.add(subjectsem3id);

                    final diplomasubjectsem3 = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    String sub = '  ${diplomasubjectsem3['Subject']}';
                    diplomasubjectssem3.add(sub);

                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DiplomaSyTyFyMstPaper(
                              diplomayearids: widget.diplomayearIds,
                              diplomadepartids: widget.diplomadepartId,
                              diplomasemestid: widget.diplomasemIds,
                              diplomasubjecid: subjectsem3id,
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

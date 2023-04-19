import 'package:flutter/material.dart';
import 'package:vjti_previous/degree/fypapersem2.dart';

class SyPaper extends StatefulWidget {
 const  SyPaper({super.key, this.subid});
final  String? subid;

  @override
  State<SyPaper> createState() => _SyPaperState();
}

class _SyPaperState extends State<SyPaper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'MST [Sem1]',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontStyle: FontStyle.italic),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Sem2paper();
                }));
              },
              child: const Text("SEM2",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontStyle: FontStyle.italic)))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blueGrey,
            height: 350,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            color: Colors.orange,
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Text(
                'ESE',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Container(
            color: Colors.green,
            height: 350,
            width: MediaQuery.of(context).size.width,
          )
        ],
      ),
    );
  }
}
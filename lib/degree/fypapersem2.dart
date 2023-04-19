import 'package:flutter/material.dart';

class Sem2paper extends StatefulWidget {
 const Sem2paper({super.key, this.subid});
 final String? subid;

  @override
  State<Sem2paper> createState() => _Sem2paperState();
}

class _Sem2paperState extends State<Sem2paper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'MST [Sem2]',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontStyle: FontStyle.italic),
        ), 
        actions: [
          TextButton(onPressed: (){}, child: const Text("SEM1" , style: TextStyle(
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
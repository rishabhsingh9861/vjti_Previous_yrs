// ignore_for_file: camel_case_types

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/drawer.dart';
import 'package:vjti_previous/utilities/routes.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  void signUserOut() async {
     FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacementNamed(context, MyRoutes.onBoard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('VJTI PREVIOUS YEARS'),
          actions: [
            IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
          ],
        ),
        drawer: const myDrawer(),
        body: Column(children: [
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Container(
              height: 80,
              width: 350,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 149, 223, 225),
                  borderRadius: BorderRadius.circular(15)),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.allYearDegree);
                  },
                  child: const Text(
                    "DEGREE",
                    style: TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 60,
                    ),
                  )),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            height: 80,
            width: 350,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 149, 223, 225),
                borderRadius: BorderRadius.circular(15)),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.allYearDiploma);
                },
                child: const Text(
                  "DIPLOMA",
                  style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 60,
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}

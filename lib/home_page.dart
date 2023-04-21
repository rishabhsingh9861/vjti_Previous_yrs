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
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacementNamed(context, MyRoutes.onBoard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('VJTI PREVIOUS YEARS'),
          actions: [
            IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
          ],
        ),
        drawer: myDrawer(),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 25,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.allYearDegree);
                },
                child: const Text(
                  "DEGREE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                      fontStyle: FontStyle.italic),
                )),
          ),
          const SizedBox(
            height: 150,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.allYearDiploma);
              },
              child: const Text(
                "DIPLOMA",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    fontStyle: FontStyle.italic),
              )),
        ]),
      ),
    );
  }
}

// ignore: duplicate_ignore
// ignore_for_file: camel_case_types, duplicate_ignore

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/utilities/routes.dart';

class onboard extends StatefulWidget {
  const onboard({super.key});

  @override
  State<onboard> createState() => _onboardState();
}

// ignore: camel_case_types
class _onboardState extends State<onboard> {
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 150, 0, 80),
                child: Image.asset("assets/images/vjti_Quad.jpg"),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "WELCOME TO VJTI",
                style: TextStyle(
                    //  decorationStyle: TextDecorationStyle.wavy,
                    decorationColor: Colors.black,
                    color: Color.fromARGB(255, 105, 229, 240),
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                   // fontStyle: FontStyle.italic
                   ),
              ),
              const SizedBox(
                height: 160,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, MyRoutes.loginRoute);
                        },
                        child: const Text(
                          "NEXT",
                          style: TextStyle(
                            fontFamily: 'DancingScript',
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

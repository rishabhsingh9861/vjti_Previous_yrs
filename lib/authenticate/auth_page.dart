// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/home_page.dart';
import 'package:vjti_previous/login.dart';
import 'package:vjti_previous/on_board.dart';

// ignore: camel_case_types
class authPage extends StatelessWidget {
  const authPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return const homePage();
        } else {
          return const onboard();
        }
      },
    ));
  }
}

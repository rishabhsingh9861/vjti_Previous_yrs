import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vjti_previous/authenticate/auth_page.dart';
import 'package:vjti_previous/degree/all_yearDegree.dart';
import 'package:vjti_previous/degree/departments.dart';
import 'package:vjti_previous/degree/test.dart';
import 'package:vjti_previous/diploma/allYearDiploma.dart';
import 'package:vjti_previous/forgot_password.dart';
import 'package:vjti_previous/home_page.dart';
import 'package:vjti_previous/login.dart';
import 'package:vjti_previous/on_board.dart';
import 'package:vjti_previous/utilities/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      // home: const onboard(),
      routes: {
        "/": (context) => const authPage(),
        MyRoutes.loginRoute: (context) => const login(),
        MyRoutes.onBoard: (context) => const onboard(),
        MyRoutes.homePage: (context) => const homePage(),
        MyRoutes.forgotPassword: (context) => const forgotPassword(),
        MyRoutes.allYearDegree:(context) => const allYearDegree(),
        MyRoutes.allYearDiploma:(context) => const allYearDiploma(),
        MyRoutes.departments:(context) =>  departments(),
     },
    );
  }
}

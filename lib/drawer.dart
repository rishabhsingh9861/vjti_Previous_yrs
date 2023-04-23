// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vjti_previous/developer.dart';

class myDrawer extends StatefulWidget {
  const myDrawer({super.key});

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  VoidCallbackAction() {}

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 230, 243, 129),
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  // currentAccountPictureSize: const Size.square(72),
                  // otherAccountsPicturesSize: const  Size.square(20.0),
                  // margin: EdgeInsets.zero,
                  accountName: Text(
                    user.displayName!,
                    style: const TextStyle(fontSize: 20),
                  ),

                  accountEmail: Text(
                    user.email!,
                    style: const TextStyle(fontSize: 20),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const Developer()));
              },
              leading: Image.asset("assets/images/developer_icon.png"),
              title: const Text(
                "Developer",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              tileColor: Colors.deepOrange,
            )
          ],
        ),
      ),
    ));
  }
}

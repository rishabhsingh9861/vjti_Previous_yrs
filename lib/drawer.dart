

// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class myDrawer extends StatelessWidget {
  myDrawer({super.key});
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
                  margin: EdgeInsets.zero,
                  accountName: const Text(""),
                  accountEmail: Text(user.email!),
                  currentAccountPicture: const CircleAvatar(),
                )),
            ListTile(
              onTap: () {},
              leading: Image.asset("assets/images/profile_icon.png"),
              title: const Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              tileColor: Colors.deepOrange,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {},
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

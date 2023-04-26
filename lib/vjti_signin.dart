import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vjti_previous/home_page.dart';
import 'package:vjti_previous/utilities/routes.dart';

class Vjtilogin extends StatefulWidget {
  const Vjtilogin({super.key});

  @override
  State<Vjtilogin> createState() => _VjtiloginState();
}

class _VjtiloginState extends State<Vjtilogin> {
  bool loading = false;

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? guser = await GoogleSignIn()
        .signIn(); // begin the interactive the signin process

    final GoogleSignInAuthentication gauth =
        await guser!.authentication; // obtain authentication request

    final credential = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );

    return  FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const homePage()));
    }).catchError((e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 233, 184),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/Vjti_logo.png",
                color: Colors.black,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: signInWithGoogle,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      height: 40,
                      width: 350,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 149, 223, 225),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/Vjti_logo.png',
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Login With Vjti Email Id',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

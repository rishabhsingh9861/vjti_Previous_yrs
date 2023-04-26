import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Developer extends StatefulWidget {
  const Developer({super.key});

  @override
  State<Developer> createState() => _DeveloperState();
}

class _DeveloperState extends State<Developer> {
  final String _url = 'https://www.linkedin.com/in/rishabh-singh-21b3b8227';
  final String _phoneNumber = '7231957066';
  final String _email = 'rtSingh_b21@ci.vjti.ac.in';
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 150, 247, 229),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://media.licdn.com/dms/image/D4D03AQFoB4t4XkkYwg/profile-displayphoto-shrink_400_400/0/1665521052467?e=1687392000&v=beta&t=32kDNLHSzIdkDWV1V1PLUUqKjOoGfdCQ6kU1p_5oLNw'),
                  radius: 110,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 450,
                width: 350,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 218, 227, 246),
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'My name is Rishabh Singh, and I am an app developer currently pursuing a degree in Civil Engineering from VJTI College in India. While my background may seem unconventional, I have found that the intersection of technology and engineering is where my passions truly lie. '
                    '                                                         '
                    'I have always been fascinated by the power of technology and its ability to transform the world around us. As a developer, I am constantly seeking new and innovative ways to use technology to improve people\'s lives and make a positive impact on society. ',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          if (await launchUrlString(_url)) {
                            await canLaunchUrlString(_url);
                          }
                        },
                        child: Image.asset('assets/images/linkedin.png')),
                    const SizedBox(
                      width: 100,
                    ),
                    InkWell(
                        onTap: () async {
                          final gmail = 'mailto:$_email';
                          if (await launchUrlString(gmail)) {
                            await canLaunchUrlString(gmail);
                          }
                        },
                        child: Image.asset('assets/images/gmail.png')),
                    const SizedBox(
                      width: 100,
                    ),
                    InkWell(
                        onTap: () async {
                          final call = 'tel:$_phoneNumber';
                          if (!await launchUrlString(call)) {
                            await canLaunchUrlString(call);
                          }
                        },
                        child: Image.asset('assets/images/phone.png')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

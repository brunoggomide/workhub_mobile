import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:workhub_mobile/views/auth/login/login.dart';

import '../auth/sign up/sign-up.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: 120,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(177, 47, 47, 1),
                  shape: BoxShape.rectangle,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('Work-Hub'),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Image.asset("assets/images/homepage.jpg", scale: 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(177, 47, 47, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) {
                            return Login();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'ENTRAR',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(
                          width: 2, color: Color.fromRGBO(177, 47, 47, 1)),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) {
                            return SignUp();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'CADASTRAR',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(177, 47, 47, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

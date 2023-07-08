import 'dart:ui';

import 'package:flutter/material.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/login_screen.png'),
                        fit: BoxFit.cover)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'GEOSAFE',
                      style: GoogleFonts.poppins(
                          letterSpacing: 15,
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Track. Trace. Transform Your Journey.',
                      style: GoogleFonts.chakraPetch(
                          color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Get Started with',
                      style: GoogleFonts.quicksand(
                          fontSize: 17,
                          textStyle: const TextStyle(color: Colors.white)),
                    ),
                    const Padding(padding: EdgeInsets.all(20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 70,
                      child: Container(
                        color: Colors.grey.withOpacity(0.5),
                        child: TextField(
                          maxLength: 10,
                          autocorrect: true,
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            letterSpacing: 6,
                            color: Colors.white,
                          ),
                          keyboardType: TextInputType.phone,
                          cursorColor: const Color.fromRGBO(255, 255, 255, 1),
                          cursorOpacityAnimates: true,
                          cursorWidth: 3,
                          cursorRadius: const Radius.circular(8),
                          decoration: const InputDecoration(
                            counterText: "",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: Colors.white,
                            ),
                            contentPadding: EdgeInsets.all(0),
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(50)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.chakraPetch(
                          fontSize: 20,
                        ),
                      ),
                    ),
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

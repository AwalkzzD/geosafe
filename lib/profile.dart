import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geosafe/bottomnavigationbar.dart';
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: const BottomNavBarCurvedFb3(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 87, 34),
                  Color.fromARGB(255, 3, 169, 244),
                ],
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Edit Profile",
                  style: GoogleFonts.chakraPetch(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        backgroundImage: (_image != null)
                            ? Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ).image
                            : const AssetImage('assets/profile_picture.png'),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final picker = ImagePicker();

                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          setState(() {
                            _image = File(pickedFile.path);
                          });
                        }
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 255, 87, 34),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
                  child: Column(
                    children: [
                      TextField(
                        cursorOpacityAnimates: true,
                        style: GoogleFonts.chakraPetch(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2),
                        cursorColor: Colors.white54,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1.5, color: Colors.white70),
                          ),
                          labelText: 'Name',
                          labelStyle: GoogleFonts.chakraPetch(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        cursorOpacityAnimates: true,
                        keyboardType: TextInputType.phone,
                        style: GoogleFonts.chakraPetch(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2),
                        cursorColor: Colors.white54,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1.5, color: Colors.white70),
                          ),
                          labelText: 'Phone Number',
                          labelStyle: GoogleFonts.chakraPetch(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        cursorOpacityAnimates: true,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.chakraPetch(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2),
                        cursorColor: Colors.white54,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1.5, color: Colors.white70),
                          ),
                          labelText: 'Email',
                          labelStyle: GoogleFonts.chakraPetch(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geosafe/bottomnavigationbar.dart';
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'database_operations.dart';
import 'package:geosafe/notification_services.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DatabaseService databaseService = DatabaseService();
  NotificationApi notificationApi = NotificationApi();
  File? _image;
  final nameController = TextEditingController(),
      phoneController = TextEditingController(),
      emailController = TextEditingController();

  @override
  void initState() {
    notificationApi.initializeNotifications();
    fetchData();
    super.initState();
  }

  void fetchData() async {
    Map map = await databaseService.fetchProfile();
    setState(() {
      nameController.text = map['NAME'];
      phoneController.text = map['PHONE NUM'];
      emailController.text = map['EMAIL'];
    });
  }

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
                        controller: nameController,
                        cursorOpacityAnimates: true,
                        style: GoogleFonts.chakraPetch(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2),
                        cursorColor: Colors.white54,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          prefixIconColor: Colors.white,
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
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: phoneController,
                        cursorOpacityAnimates: true,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        autocorrect: true,
                        style: GoogleFonts.chakraPetch(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2),
                        cursorColor: Colors.white54,
                        decoration: InputDecoration(
                          counterText: "",
                          prefixIcon: const Icon(Icons.phone),
                          prefixIconColor: Colors.white,
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
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: emailController,
                        cursorOpacityAnimates: true,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.chakraPetch(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2),
                        cursorColor: Colors.white54,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          prefixIconColor: Colors.white,
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
                      const SizedBox(
                        height: 50,
                      ),
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
                        onPressed: () async {
                          databaseService.updateProfile(nameController.text,
                              phoneController.text, emailController.text);
                          if (await Permission.notification
                              .request()
                              .isGranted) {
                            notificationApi.sendNotification('Successfull!...',
                                'Your profile was updated successfully');
                          }
                        },
                        child: Text(
                          'Update',
                          style: GoogleFonts.chakraPetch(
                            fontSize: 20,
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

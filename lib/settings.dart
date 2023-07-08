import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geosafe/bottomnavigationbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'database_operations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  DatabaseService databaseService = DatabaseService();
  int _itemCount = 0;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    var temp = await databaseService.fetchSpeedLimit();
    setState(() {
      _itemCount = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: const BottomNavBarCurvedFb2(),
      body: Stack(
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
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Settings',
                        style: GoogleFonts.chakraPetch(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Devarshi',
                        style: GoogleFonts.chakraPetch(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RawScrollbar(
                    thumbColor: Colors.transparent,
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.white38, width: 1)),
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    interactive: true,
                    thickness: 7,
                    // radius: const Radius.circular(20),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        buildTileSwitch(1, Icons.settings, 'Setting 1'),
                        buildTileSwitch(2, Icons.settings, 'Setting 2'),
                        buildTileSwitch(3, Icons.settings, 'Setting 3'),
                        buildTileStepper(4, Icons.speed_sharp, 'Speed Limit'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTileSwitch(int index, IconData iconData, String title) {
    return ListTile(
      leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Icon(
            iconData,
            color: Colors.white,
          )),
      title: Text(title,
          style: GoogleFonts.chakraPetch(fontSize: 15, color: Colors.white)),
      trailing: SwitcherButton(
        size: 50,
        onColor: Colors.black54,
        offColor: Colors.white30,
        onChange: (value) {
          switch (index) {
            case 1:
              debugPrint('1st Tile clicked');
              break;
            case 2:
              debugPrint('2nd Tile clicked');
              break;
            case 3:
              debugPrint('3rd Tile clicked');
              break;
          }
        },
      ),
    );
  }

  Widget buildTileStepper(int index, IconData iconData, String title) {
    return ListTile(
      leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Icon(
            iconData,
            color: Colors.white,
          )),
      title: Text(title,
          style: GoogleFonts.chakraPetch(fontSize: 15, color: Colors.white)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _itemCount != 0
              ? IconButton(
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white38,
                  ),
                  onPressed: () async {
                    setState(() => _itemCount -= 10);
                    databaseService.updateSpeedLimit(_itemCount);
                  },
                )
              : Container(),
          Text(
            _itemCount.toString(),
            style: GoogleFonts.chakraPetch(
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white38),
            onPressed: () async {
              setState(() => _itemCount += 10);
              databaseService.updateSpeedLimit(_itemCount);
            },
          )
        ],
      ),
    );
  }
}

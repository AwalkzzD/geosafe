import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geosafe/database_operations.dart';
import 'package:geosafe/location.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:geosafe/notification_services.dart';
import 'package:geosafe/bottomnavigationbar.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationApi notificationApi = NotificationApi();
  DatabaseService databaseService = DatabaseService();
  GlobalKey<KdGaugeViewState> speed = GlobalKey<KdGaugeViewState>();
  double temp = 0.0;
  int? speedLimit;
  bool engineStatus = false;
  String? username;

  // void decrease() {
  //   if (temp > 0) {
  //     setState(() {
  //       temp -= 5;
  //       speed.currentState!.updateSpeed(temp,
  //           animate: true, duration: const Duration(milliseconds: 400));
  //     });
  //   }
  // }

  // void increase() async {
  //   setState(() {
  //     temp += 5;
  //     speed.currentState!.updateSpeed(temp,
  //         animate: true, duration: const Duration(milliseconds: 400));
  //   });

  //   if (temp > speedLimit!) {
  //     if (await Permission.notification.request().isGranted) {
  //       notificationApi.sendNotification(
  //           'Overspeeding detected', 'Current speed ${temp.toInt()} km/h');
  //     }
  //   }
  // }

  void fetchSpeed() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.onValue.listen((DatabaseEvent event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      setState(() {
        temp = data['CURRENT SPEED'] as double;
        speed.currentState!.updateSpeed(temp,
            animate: true, duration: const Duration(milliseconds: 400));
        var temp1 = data['NAME'] as String;
        username = temp1;
      });
    });
  }

  void fetchSpeedLimit() async {
    speedLimit = await databaseService.fetchSpeedLimit();
  }

  @override
  void initState() {
    notificationApi.initializeNotifications();
    fetchSpeed();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetchSpeedLimit();
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: const BottomNavBarCurvedFb1(),
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
          Column(
            children: [
              SafeArea(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: GoogleFonts.chakraPetch(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          username ?? 'User',
                          // 'Devarshi',
                          style: GoogleFonts.chakraPetch(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 50,
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: KdGaugeView(
                        fractionDigits: 1,
                        divisionCircleColors: Colors.white,
                        innerCirclePadding: 20,
                        key: speed,
                        minSpeed: 0,
                        maxSpeed: 150,
                        minMaxTextStyle: GoogleFonts.chakraPetch(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        speed: 0,
                        subDivisionCircleColors: Colors.white,
                        speedTextStyle: GoogleFonts.chakraPetch(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                        unitOfMeasurementTextStyle: GoogleFonts.chakraPetch(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        activeGaugeColor: Colors.green,
                        alertSpeedArray: const [60, 80, 100],
                        alertColorArray: const [
                          Colors.green,
                          Colors.orange,
                          Colors.red
                        ],
                      ),
                    ),
                    // OutlinedButton(
                    //   onPressed: () => increase(),
                    //   child: Text(
                    //     'Increase Speed',
                    //     style: GoogleFonts.chakraPetch(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    // OutlinedButton(
                    //   onPressed: () => decrease(),
                    //   child: Text(
                    //     'Decrease Speed',
                    //     style: GoogleFonts.chakraPetch(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                    RollingSwitch.icon(
                      circularColor: Colors.white,
                      initialState: engineStatus,
                      rollingInfoRight: RollingIconInfo(
                        icon: Icons.car_rental_outlined,
                        text: Text(
                          'On',
                          style: GoogleFonts.chakraPetch(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      rollingInfoLeft: RollingIconInfo(
                        icon: Icons.car_crash_outlined,
                        backgroundColor: Colors.grey,
                        text: Text(
                          '      Off',
                          style: GoogleFonts.chakraPetch(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      onChanged: (bool state) {
                        (state)
                            ? databaseService.turnOn()
                            : databaseService.turnOff();
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              width: 1.4, color: Colors.white60)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewLocation()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Find My Car',
                          style: GoogleFonts.chakraPetch(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

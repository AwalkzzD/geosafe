import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_database/firebase_database.dart';

class ViewLocation extends StatefulWidget {
  const ViewLocation({super.key});

  @override
  State<ViewLocation> createState() => ViewLocationState();
}

class ViewLocationState extends State<ViewLocation>
    with AutomaticKeepAliveClientMixin {
  double deflatitude = 22.6708, deflongitude = 71.5274;
  double? latitude, longitude;
  double? userlatitude, userlongitude;
  late Position position;

  @override
  bool get wantKeepAlive => true;

  void getCurrentLocation() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.onValue.listen((DatabaseEvent event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      setState(() {
        latitude = data['LATITUDE'] as double;
        longitude = data['LONGITUDE'] as double;
      });
    });

    await Permission.location.request();
    position = await Geolocator.getCurrentPosition();
    setState(() {
      userlatitude = position.latitude;
      userlongitude = position.longitude;
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: FlutterMap(
        options: MapOptions(
          minZoom: 2,
          maxZoom: 16,
          zoom: 5,
          center: LatLng(latitude ?? deflatitude, longitude ?? deflongitude),
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/awalkzzd/clk77bho1009i01nwb1ricgbd/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXdhbGt6emQiLCJhIjoiY2xlMzFwcnphMDRobjNwb2ltdWZuNjNhOSJ9.SacNtBuOCBUOjpbH8f8GWg',
            additionalOptions: const {
              'accessToken':
                  'pk.eyJ1IjoiYXdhbGt6emQiLCJhIjoiY2xlMzFwcnphMDRobjNwb2ltdWZuNjNhOSJ9.SacNtBuOCBUOjpbH8f8GWg',
              'id': 'mapbox://styles/awalkzzd/clk77bho1009i01nwb1ricgbd'
            },
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(
                    userlatitude ?? deflatitude, userlongitude ?? deflongitude),
                builder: (context) {
                  return const Icon(
                    Icons.person_pin_circle_outlined,
                    color: Color.fromARGB(255, 255, 87, 34),
                    size: 40,
                  );
                },
              ),
              Marker(
                point:
                    LatLng(latitude ?? deflatitude, longitude ?? deflongitude),
                builder: (context) {
                  return Image.asset(
                    'assets/car_icon.png',
                    fit: BoxFit.fill,
                  );
                },
              )
            ],
          ),
          PolylineLayer(
            polylineCulling: true,
            polylines: [
              Polyline(
                points: [
                  LatLng(userlatitude ?? deflatitude,
                      userlongitude ?? deflongitude),
                  LatLng(latitude ?? deflatitude, longitude ?? deflongitude)
                ],
                color: const Color.fromARGB(255, 3, 169, 244),
                strokeWidth: 2,
                isDotted: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}

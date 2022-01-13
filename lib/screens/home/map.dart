import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);
  static String id = "MapPage";

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String _mapStyle;
  GoogleMapController _mapController;
  Set<Marker> sellerMarkers = Set<Marker>();
  BitmapDescriptor myIcon;

  @override
  void initState() {
    checkPermissions();
    rootBundle.loadString('assets/map_style.txt').then((value) {
      setState(() {
        _mapStyle = value;
      });
    });
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/marker.png').then((value){
          setState(() {
            myIcon = value;
          });
    });

    super.initState();
  }

  _onMapCreate(GoogleMapController controller) {
    if (mounted) {
      setState(() {
        _mapController = controller;
        controller.setMapStyle(_mapStyle);
      });
    }
  }

  checkPermissions() async {
    await Permission.locationAlways.request().isGranted &&
        await Permission.location.request().isGranted &&
        await Permission.locationWhenInUse.request().isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      markers: sellerMarkers,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          15.734730,
          32.577591,
        ),
        zoom: 12,
      ),
      onMapCreated: (GoogleMapController controller) {
        setState(() {
          _onMapCreate(controller);
          sellerMarkers.addAll({
            Marker(
                markerId: MarkerId('1'),
                icon:
                myIcon,
                position: LatLng(
                  15.734730,
                  32.577591,
                )),
            Marker(
                markerId: MarkerId('2'),
                icon: myIcon,
                position: LatLng(
                  15.732730,
                  32.523591,
                )),
          });
        });
      },
    ));
  }
}

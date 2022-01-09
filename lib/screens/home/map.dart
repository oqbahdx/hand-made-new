import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);
  static String id = "MapPage";

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String _mapStyle;
  BitmapDescriptor myIcon;
  var _markers = HashSet<Marker>();

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'assets/marker.png')
        .then((onValue) {
      myIcon = onValue;
    });
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  _onMapCreated(GoogleMapController controller) {
    if (mounted)
      setState(() {
        controller.setMapStyle(_mapStyle);
      });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GoogleMap(
        markers: _markers,
        trafficEnabled: false,
        compassEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(15.713290, 32.559315),
          zoom: 10.2,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }
}

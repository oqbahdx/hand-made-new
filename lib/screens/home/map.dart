import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/navigator.dart';
import 'package:hand_made_new/screens/account/sellers_details.dart';
import 'package:hand_made_new/styles/colors.dart';
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
  Set<Marker> sellerMarkers = <Marker>{};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor myIcon;
  var seller = [];

  @override
  void initState() {
    checkPermissions();
    getSellersMarkers();
    rootBundle.loadString('assets/map_style.txt').then((value) {
      setState(() {
        _mapStyle = value;
      });
    });
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(60, 60)), 'assets/marker.png')
        .then((value) {
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

  getSellersMarkers() {
    seller = [];
    FirebaseFirestore.instance.collection('users').get().then((duc) {
      if (duc.docs.isNotEmpty) {
        for (int i = 0; i <= duc.docs.length; i++) {
          seller.add(duc.docs[i].data());
         initMarker(duc.docs[i].data(), duc.docs[i].id);
        }
      }
    });
  }

  void initMarker(specify, specifyId) {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(specify['location'].latitude , specify['location'].longitude,),
        icon: myIcon,

        onTap: (){
          moveToPageWithData(context, namePage: SellerDetails(
            uId: specify['uid'],
            name: specify['name'],
            image: specify['profileImage'],
          ));
        },
        infoWindow:
            InfoWindow(title: specify['name'], snippet: specify['email']));
    setState(() {
      markers[markerId] = marker;
    });
  }

  checkPermissions() async {
    await Permission.locationAlways.request().isGranted &&
        await Permission.location.request().isGranted &&
        await Permission.locationWhenInUse.request().isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var seller = HandCubit.get(context).userModel;
        return ConditionalBuilder(
          condition: state is! HandGetSellersLoadingState,
          builder: (context) => Scaffold(
              body: Container(
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
            child: GoogleMap(
              markers: Set<Marker>.of(markers.values),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: const CameraPosition(
                target: LatLng(
                  15.734730,
                  32.577591,
                ),
                zoom: 12,
              ),
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  _onMapCreate(controller);
                });
              },
            ),
          )),
          fallback: (context) => Container(
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

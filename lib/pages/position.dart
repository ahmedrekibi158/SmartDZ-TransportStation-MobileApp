import 'dart:async';
import 'dart:convert';

import 'package:app0/pages/appBar.dart';
import 'package:app0/pages/url.dart';
import 'package:app0/param/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'constants.dart';

class Position extends StatefulWidget {
  Position({
    required this.id,
    Key? key,
  }) : super(key: key);
  //final List<Reservation> reser;
  String id;
  @override
  _positionState createState() => _positionState(id);
}

class _positionState extends State<Position> {
  _positionState(this.id);
  String id;

  late GoogleMapController mapController;

  static LatLng _depart = LatLng(36.20759856690683, 5.423518279484859);
  //final LatLng _dest = const LatLng(36.31611540695481, 6.621028101162577);
  static LatLng _dest = LatLng(36.180083968192584, 5.458618787481543);
  //final LatLng _g1 = const LatLng(36.17234362233228, 5.716078075971749);
  //final LatLng _g2 = const LatLng(36.12438827863635, 6.057910676110234);
  //final LatLng _g3 = const LatLng(36.28134379402553, 6.5172225002997175);
  //final Completer<GoogleMapController> _controller = Completer();
  List<LatLng> polylineCoordinates = [];
  //LocationData? currentLocation;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  /*void getCurrentLocation() async {
    Location location = Location();

    //GoogleMapController googleMapController = await _controller.future;

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              newLoc.latitude!,
              newLoc.longitude!,
            ),
          ),
        ),
      );
    });
  }/***/ */
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(_depart.latitude, _depart.longitude),
        PointLatLng(_dest.latitude, _dest.longitude));

    /*LatLng p1 = LatLng(_depart.latitude, _depart.longitude);
    LatLng p2 = LatLng(_depart.latitude, _depart.longitude);

    polylineCoordinates.add(p1);
    polylineCoordinates.add(p2);*/

    print('notEmpty');
    print(result);
    print(result.points.length);
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  /* @override
  void initState() {
    //getCurrentLocation();
    //getPolyPoints();
    print(polylineCoordinates.length);
    //print(polylineCoordinates);
    super.initState();
  }*/
  Timer? timer;
  @override
  void initState() {
    super.initState();
    setState(() {
      getPosition();
      /*timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      });*/
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(seconds: 3), () {});

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appbar(height, width, 'Position de bus', 2, context),
      body: /* currentLocation == null
          ? Center(
              child: Text('Loading'),
            )
          :*/
          GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _depart,
          zoom: 11.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('markerId'),
            position: _depart,
          ),
        },
        //markers: markers.toSet(),
        polylines: {
          Polyline(
            polylineId: PolylineId('route'),
            points: polylineCoordinates,
            color: blueColor,
            width: 6,
          )
        },
      ),
    );
  }

  int c = 0;
  getPosition() async {
    setState(() {
      c = int.parse(id);
    });
    String url = urrr + 'localisation/gare/getLocalisation?voyage=$c';

    var res = await http.get(
      Uri.parse(url), // ou url idk
      headers: headers,
    );
    print('mmap');
    print(res.body);
    print('position');
    var localisation = json.decode(res.body)['localisation']; //error
    print(localisation);

    setState(() {
      print('depart');
      print(_depart);
      //_depart = LatLng(localisation['lat'], localisation['lng']);
      print(localisation['lat']);
      //passenger = userJson;
    });
  }

  Map<String, String> headers = {
    "Authorization": "Bearer " + jj.jw,
    "Accept": "application/json; charset=UTF-8",
    "Content-Type": "application/json",
    "Access-Control-Allow-Methods": "GET, OPTIONS",
    "Access-Control-Allow-Origin": "*",
  };
}

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosabhhgraduationproject/data/model/Address.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> myMarker = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press (navigate back or any other action)
            Navigator.pop(context);
          },
        ),
      ),
      body: GoogleMap(
        initialCameraPosition:
        CameraPosition(target: LatLng(32.223990248626585, 35.259239450097084), zoom: 12.0),
        markers: Set.from(myMarker),
        onTap: _handleTap,
      ),
    );
  }

  _handleTap(LatLng tappedPoint) async {
    print(tappedPoint);
    String selectedPointName = ""; // Variable to store the selected point name

    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
    });
    // Reverse geocode to get the address or location name
    List<Placemark> placemarks = await placemarkFromCoordinates(
      tappedPoint.latitude,
      tappedPoint.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      setState(() {
        selectedPointName = "${placemark.name}/${placemark.street}";
Navigator.of(context).pop(Address(null,false,Icons.home,tappedPoint.latitude ,tappedPoint.longitude,selectedPointName));
        // selectedPointName = placemark.name ?? "";
        print("_____weee$selectedPointName");
      });
    }
  }
}


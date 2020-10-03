import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsTest extends StatefulWidget {
  @override
  _MapsTestState createState() => _MapsTestState();
}

class _MapsTestState extends State<MapsTest> {
  final Set<Marker> _markers = {};
  final LatLng _currentPosition = LatLng(3.595196, 98.672226);

  @override
  void initState() {
    _markers.add(
      Marker(
        markerId: MarkerId("3.595196, 98.672226"),
        position: _currentPosition,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Flutter'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 14.0,
        ),
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //searchNearby(latitude, longitude); // 2
        },
        label: Text('Places Nearby'), // 3
        icon: Icon(Icons.place), // 4
      ),
    );
  }
}

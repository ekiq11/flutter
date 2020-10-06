import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsTest extends StatefulWidget {
  @override
  _MapsTestState createState() => _MapsTestState();
}

class _MapsTestState extends State<MapsTest> {
  final Set<Marker> _markers = {};
  final LatLng _currentPosition = LatLng(-8.650979, 116.324944);

  @override
  void initState() {
    _markers.add(
      Marker(
        markerId: MarkerId("-8.650979, 116.324944"),
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
        title: Text('Lokasi Wisata Kuliner'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 30.0,
        ),
        markers: _markers,
      ),
    );
  }
}

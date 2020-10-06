import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapsTest extends StatefulWidget {
  final String latitude;
  final String longitude;
  final String namaTempat;

  MapsTest({
    Key key,
    this.latitude,
    this.longitude,
    this.namaTempat,
  }) : super(key: key);

  @override
  _MapsTestState createState() => _MapsTestState();
}

class _MapsTestState extends State<MapsTest> {
  final Set<Marker> _markers = {};
  String latitude, longitude, namaTempat;

  @override
  void initState() {
    getPref() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        latitude = preferences.getString("${widget.latitude}");
        longitude = preferences.getString("${widget.longitude}");
      });
    }

    _markers.add(
      Marker(
        markerId: MarkerId("${widget.latitude}, ${widget.longitude}"),
        position: LatLng(double.parse("${widget.latitude}"),
            double.parse("${widget.longitude}")),
        infoWindow: InfoWindow(title: '${widget.namaTempat}'),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
    getPref();
    print("${widget.longitude}");
    print("${widget.latitude}");
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
          target: LatLng(double.parse("${widget.latitude}"),
              double.parse("${widget.longitude}")),
          zoom: 15.0,
        ),
        markers: _markers,
      ),
    );
  }
}

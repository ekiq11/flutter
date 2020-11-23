import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pdp_wisatakuliner/podo/maps_services.dart';
import 'package:pdp_wisatakuliner/util/jsonMaps.dart';

class MapsNew extends StatefulWidget {
  @override
  _MapsNewState createState() => _MapsNewState();
}

class _MapsNewState extends State<MapsNew> {
  GoogleMapController _controller;

  List<Maps> _listmenu = [];

  @override
  void initState() {
    super.initState();

    MapServices.getMaps().then((listmenu) {
      setState(() {
        _listmenu = listmenu;
      });
      _listmenu.forEach((element) {
        allMarkers.add(Marker(
          markerId: MarkerId(element.namaTempat),
          draggable: false,
          infoWindow:
              InfoWindow(title: element.namaTempat, snippet: element.alamat),
          position: LatLng(
              double.parse(element.latitude), double.parse(element.longitude)),
        ));
      });
      _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
        ..addListener(_onScroll);
    });
  }

  List<Marker> allMarkers = [];

  PageController _pageController;

  int prevPage;

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            // moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 150.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.wisatakuapps.com/api/upload/' +
                                              _listmenu[index].img),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _listmenu[index].namaTempat,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _listmenu[index].alamat,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: 170.0,
                                  child: Text(
                                    "Jam Buka : " +
                                        _listmenu[index].jamBuka +
                                        " - Tutup : " +
                                        _listmenu[index].jamTutup,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ])
                        ]))))
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height - 50.0,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(-8.646460, 116.112308), zoom: 12.0),
            markers: Set.from(allMarkers),
            onMapCreated: mapCreated,
          ),
        ),
        Positioned(
          bottom: 20.0,
          child: Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _listmenu.length,
              itemBuilder: (BuildContext context, int index) {
                return _coffeeShopList(index);
              },
            ),
          ),
        )
      ],
    ));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            double.parse(_listmenu[_pageController.page.toInt()].latitude),
            double.parse(_listmenu[_pageController.page.toInt()].longitude)),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}

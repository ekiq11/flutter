import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/modals/api.dart';
import 'package:pdp_wisatakuliner/podo/wilayah_services.dart';
import 'package:pdp_wisatakuliner/screens/admin/main_screen_admin.dart';
import 'package:pdp_wisatakuliner/screens/admin/tambah_data.dart';
import 'package:pdp_wisatakuliner/util/tampi;_wilayah.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

class MyLokasi extends StatefulWidget {
  @override
  _MyLokasiState createState() => _MyLokasiState();
}

class _MyLokasiState extends State<MyLokasi> {
  File _imageFile;
  String namaTempat,
      alamat,
      telepon,
      latitude,
      longitude,
      jamBuka,
      jamTutup,
      idWilayah,
      idUser;
  final _key = new GlobalKey<FormState>();
  bool _scurePassword = true;
  showHide() {
    setState(() {
      _scurePassword = !_scurePassword;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      tambahwilayah();
    }
  }

  List<Wilayah> _wilayah = [];

  @override
  void initState() {
    super.initState();

    WilayahServices.getWilayah().then((wilayah) {
      setState(() {
        _wilayah = wilayah;
      });
    });
  }

  String id = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
    });
  }

  tambahwilayah() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        id = preferences.getString("id");
      });
      var stream =
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));

      var length = await _imageFile.length();
      var uri = Uri.parse(BaseURL.tambahLokasi);
      final request = http.MultipartRequest("POST", uri);
      request.fields['namaTempat'] = namaTempat;
      request.fields['alamat'] = alamat;
      request.fields['telepon'] = telepon;
      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;
      request.fields['jamBuka'] = jamBuka;
      request.fields['jamTutup'] = jamTutup;
      request.fields['idWilayah'] = idWilayah;
      request.fields['idUser'] = preferences.getString("id");
      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(_imageFile.path)));
      var response = await request.send();
      if (response.statusCode > 2) {
        Widget okButton = FlatButton(
            child: Text("OK"),
            onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MainScreenAdmin();
                    },
                  ),
                ));

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Berhasil"),
          content: Text("Tambah lokasi berhasil"),
          actions: [
            okButton,
          ],
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      } else {
        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () => Navigator.pop(context),
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Gagal"),
          content: Text("Tambah lokasi Gagal"),
          actions: [
            okButton,
          ],
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  pilihGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.white),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 25.0,
              ),
              child: Text(
                "Tambah Data Lokasi",
                style: TextStyle(
                  fontFamily: 'arial',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Card(
              elevation: 3.0,
              child: Container(),
            ),
            SizedBox(height: 30.0),
            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: TextField(
                  onChanged: (e) => namaTempat = e,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "Nama Tempat",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: TextField(
                  onChanged: (e) => alamat = e,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "Alamat",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: TextField(
                  onChanged: (e) => telepon = e,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "Telepon",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: TextField(
                  onChanged: (e) => latitude = e,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "Koordinat Latitude",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: TextField(
                  onChanged: (e) => longitude = e,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "Koordinat Longitude",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: TextField(
                  onChanged: (e) => jamBuka = e,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "Jam Buka",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: TextField(
                  onChanged: (e) => jamTutup = e,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "Jam Tutup",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 3.0,
              child: Container(
                height: 50.0,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: DropdownButton(
                    hint: Text("Pilih Wilayah"),
                    underline: Container(
                      height: 1.0,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.transparent, width: 0.0))),
                    ),
                    value: idWilayah,
                    items: _wilayah.map((item) {
                      return DropdownMenuItem(
                        child: Text(item.namaWilayah),
                        value: item.id,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        idWilayah = value;
                      });
                    }),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              height: 50.0,
              child: RaisedButton(
                child: Text(
                  "Tambah Gambar".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  pilihGallery();
                },
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              height: 50.0,
              child: RaisedButton(
                child: Text(
                  "Simpan".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  tambahwilayah();
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(height: 10.0),
            Divider(
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}

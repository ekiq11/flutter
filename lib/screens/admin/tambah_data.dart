import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/modals/api.dart';
import 'package:pdp_wisatakuliner/podo/lokasi_services.dart';
import 'package:pdp_wisatakuliner/screens/admin/tambah_lokasi.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:pdp_wisatakuliner/util/lokasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahData extends StatefulWidget {
  @override
  _TambahDataState createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  String namaMenu, deskripsi, harga, img, idUser, idKuliner, idKategoriMenu;
  final _key = new GlobalKey<FormState>();
  File _imageFile;
  bool _scurePassword = true;
  showHide() {
    setState(() {
      _scurePassword = !_scurePassword;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      tambahmenu();
    }
  }

  List<Lokasi> _lokasi = [];

  @override
  void initState() {
    super.initState();
    String id = "";
    getPreferences() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        id = preferences.getString("id");
        LokasiServices.getLokasi(id).then((lokasi) {
          setState(() {
            _lokasi = lokasi;
          });
        });
      });
    }

    setState(() {
      getPreferences();
    });
  }

  String id = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
    });
  }

  tambahmenu() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        id = preferences.getString("id");
      });
      var uri = Uri.parse(BaseURL.tambahMenu);
      var stream =
          // ignore: deprecated_member_use
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      final request = http.MultipartRequest("POST", uri);
      var length = await _imageFile.length();
      request.fields['namaMenu'] = namaMenu;
      request.fields['deskripsi'] = deskripsi;
      request.fields['harga'] = harga;
      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(_imageFile.path)));
      request.fields['idUser'] = preferences.getString("id");
      request.fields['idKuliner'] = idKuliner;
      request.fields['idKategoriMenu'] = idKategoriMenu;

      var response = await request.send();
      if (response.statusCode > 2) {
        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () => Navigator.pop(context),
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Berhasil"),
          content: Text("Tambah Foto Berhasil"),
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
          content: Text("Tambah Foto Gagal"),
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
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = image;
    });
  }

  pilihCamera() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    var placeholder = Container(
        width: double.infinity,
        height: 150.0,
        child: Image.asset('assets/img.png'));
    return Padding(
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
              "Tambah Data Menu",
              style: TextStyle(
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
          Container(
            width: double.infinity,
            height: 150.0,
            child: InkWell(
                onTap: () {
                  pilihCamera();
                },
                child: _imageFile == null
                    ? placeholder
                    : Image.file(_imageFile, fit: BoxFit.fill)),
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
                onChanged: (e) => namaMenu = e,
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
                  hintText: "Nama Menu",
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
                onChanged: (e) => deskripsi = e,
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
                  hintText: "Deskripsi",
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
                onChanged: (e) => harga = e,
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
                  hintText: "Harga",
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
                  hint: Text("Pilih lokasi"),
                  underline: Container(
                    height: 1.0,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.transparent, width: 0.0))),
                  ),
                  value: idKuliner,
                  items: _lokasi.map((item) {
                    return DropdownMenuItem(
                      child: Text(item.namaTempat),
                      value: item.id,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      idKuliner = value;
                    });
                  }),
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
                  hint: Text("Pilih Kategori Menu"),
                  underline: Container(
                    height: 1.0,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.transparent, width: 0.0))),
                  ),
                  value: idKategoriMenu,
                  items: [
                    DropdownMenuItem(
                      child: Text("Minuman"),
                      value: "1",
                    ),
                    DropdownMenuItem(
                      child: Text("Makanan Kue"),
                      value: "2",
                    ),
                    DropdownMenuItem(child: Text("Cepat Saji"), value: "3"),
                    DropdownMenuItem(child: Text("Makanan Khas"), value: "4")
                  ],
                  onChanged: (value) {
                    setState(() {
                      idKategoriMenu = value;
                    });
                  }),
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            height: 50.0,
            child: RaisedButton(
              child: Text(
                "Masukkan Lokasi Anda".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MyLokasi();
                    },
                  ),
                );
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
                tambahmenu();
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
    );
  }
}

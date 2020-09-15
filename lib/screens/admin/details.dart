import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/modals/api.dart';
import 'package:pdp_wisatakuliner/podo/tampil_komentar.dart';
import 'package:pdp_wisatakuliner/screens/admin/fav_details.dart';
import 'package:pdp_wisatakuliner/screens/admin/home_admin.dart';
import 'package:pdp_wisatakuliner/screens/home.dart';
import 'package:pdp_wisatakuliner/util/komentar_tampil.dart';
import 'package:pdp_wisatakuliner/util/const.dart';
import 'package:pdp_wisatakuliner/widgets/badge.dart';
import 'package:pdp_wisatakuliner/widgets/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

class ProductDetails extends StatefulWidget {
  final VoidCallback reload;
  final String id;
  final String jmlReview;
  final String idMenu;
  final String jmlMenu;
  final String idUser;
  final String namaMenu;
  final String deskripsi;
  final String harga;
  final String telepon;
  final String namaTempat;
  final String alamat;
  final String jamBuka;
  final String jamTutup;
  final String img;
  final bool isFav;
  final String jmlRating;

  ProductDetails(
      {Key key,
      this.reload,
      @required this.id,
      this.idMenu,
      this.jmlReview,
      this.jmlMenu,
      @required this.idUser,
      @required this.namaMenu,
      @required this.deskripsi,
      @required this.harga,
      @required this.namaTempat,
      @required this.alamat,
      @required this.telepon,
      @required this.jamBuka,
      @required this.jamTutup,
      @required this.img,
      @required this.isFav,
      this.jmlRating})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String catie = "Makanan Cepat Saji", id = "", komentar, idMenu;
  double jmlRating = 3.0;
  bool isFav = false;

  List<Komentar> _komentar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    KomentarServices.getKomentar("${widget.id}").then((komentar) {
      setState(() {
        _komentar = komentar;
        print("${widget.namaMenu}");
        //  print("${widget.jmlRating}".toString());
      });
    });
  }

  kirimKomentar() async {
    final response = await http.post(BaseURL.komentar, body: {
      "komentar": komentar,
      "rating": "$jmlRating",
      "idUser": "${widget.idUser}",
      "idMenu": "${widget.id}",
    });
    final data = jsonDecode(response.body);
    int value = data['value'];

    if (value == 1) {
      setState(() {
        // set up the button
        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProductDetails(
                      id: "${widget.id}",
                      jmlRating: jmlRating.toString(),
                      jmlMenu: "${widget.jmlMenu}",
                      jmlReview: "${widget.jmlReview}",
                      idUser: "${widget.idUser}",
                      namaMenu: "${widget.namaMenu}",
                      harga: "${widget.harga}",
                      telepon: "${widget.telepon}",
                      deskripsi: "${widget.deskripsi}",
                      namaTempat: "${widget.namaTempat}",
                      alamat: "${widget.alamat}",
                      jamBuka: "${widget.jamBuka}",
                      jamTutup: "${widget.jamTutup}",
                      img: "${widget.img}",
                      isFav: isFav);
                },
              ),
            );
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Berhasil Terkirim"),
          content: Text("Terimakasih, komentar terlah terkirim."),
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return HomeAdmin();
                },
              ),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          "Detail Makanan",
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications,
              size: 22.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return await Future.delayed(Duration(seconds: 2));
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10.0),
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.2,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        "${widget.img}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -10.0,
                    bottom: 3.0,
                    child: RawMaterialButton(
                      onPressed: () {},
                      fillColor: Colors.white,
                      shape: CircleBorder(),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                "${widget.namaMenu}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                child: Row(
                  children: <Widget>[
                    SmoothStarRating(
                      starCount: 5,
                      color: Constants.ratingBG,
                      allowHalfRating: true,
                      rating: jmlRating,
                      size: 20.0,
                      onRatingChanged: (value) {
                        setState(() {
                          jmlRating = value;
                          print(value);
                        });
                      },
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "5.0 (23 Reviews)",
                      style: TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "1 Porsi",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "Rp. ${widget.harga}",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "Deskripsi",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
              ),
              SizedBox(height: 10.0),
              Text(
                "${widget.deskripsi}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "Lokasi - ${widget.namaTempat}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
              ),
              SizedBox(height: 10.0),
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 16,
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Text(
                        "${widget.alamat}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone_iphone,
                        size: 16,
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Text(
                        "${widget.telepon}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_alarm,
                        size: 16,
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Text(
                        "Buka (${widget.jamBuka}) - Tutup (${widget.jamTutup})",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                "Review",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  SmoothStarRating(
                    starCount: 5,
                    color: Constants.ratingBG,
                    allowHalfRating: false,
                    rating: jmlRating,
                    size: 40.0,
                    onRatingChanged: (value) {
                      setState(() {
                        jmlRating = value;
                        print(value);
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    "Berikan penilaian ${widget.namaMenu} - ${widget.namaTempat}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Column(
                    children: <Widget>[
                      TextField(
                          onChanged: (e) => komentar = e,
                          decoration: InputDecoration(
                              hintText: "Add a comment",
                              contentPadding: const EdgeInsets.all(
                                20.0,
                              ),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.send),
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    kirimKomentar();
                                  }))),
                    ],
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _komentar == null ? 0 : _komentar.length,
                itemBuilder: (BuildContext context, int index) {
                  Komentar comment = _komentar[index];

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        comment.img,
                      ),
                    ),
                    title: Text(comment.nama),
                    subtitle: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SmoothStarRating(
                              starCount: 5,
                              color: Constants.ratingBG,
                              allowHalfRating: true,
                              rating: double.parse(comment.rating),
                              size: 15.0,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(
                              comment.tglKomentar,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7.0),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            comment.komentar,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: RaisedButton(
          child: Text(
            "PERGI KE LOKASI",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {},
        ),
      ),
    );
  }
}

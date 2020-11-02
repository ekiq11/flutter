import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/screens/admin/details.dart';

class GridListMenu extends StatelessWidget {
  final String id;
  final String idUser;
  final String jmlRating;
  final String jmlMenu;
  final String jmlReview;
  final String namaMenu;
  final String deskripsi;
  final String harga;
  final String telepon;
  final String namaTempat;
  final String alamat;
  final String latitude;
  final String longitude;
  final String jamBuka;
  final String jamTutup;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;

  GridListMenu(
      {Key key,
      @required this.id,
      @required this.idUser,
      this.jmlRating,
      this.jmlMenu,
      this.jmlReview,
      this.latitude,
      this.longitude,
      @required this.namaMenu,
      @required this.deskripsi,
      this.telepon,
      @required this.harga,
      this.namaTempat,
      this.alamat,
      this.jamBuka,
      this.jamTutup,
      @required this.img,
      this.isFav,
      this.rating,
      this.raters})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.6,
                width: MediaQuery.of(context).size.width / 2.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://www.wisatakuapps.com/api/upload/' + "$img",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "$namaMenu",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductDetails(
                id: id,
                jmlRating: jmlRating,
                jmlMenu: jmlMenu,
                jmlReview: jmlReview,
                idUser: idUser,
                namaMenu: namaMenu,
                harga: harga,
                telepon: telepon,
                deskripsi: deskripsi,
                namaTempat: namaTempat,
                alamat: alamat,
                latitude: latitude,
                longitude: longitude,
                jamBuka: jamBuka,
                jamTutup: jamTutup,
                img: img,
                isFav: isFav,
              );
            },
          ),
        );
      },
    );
  }
}

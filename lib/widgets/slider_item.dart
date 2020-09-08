import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/screens/details.dart';
import 'package:pdp_wisatakuliner/util/const.dart';
import 'package:pdp_wisatakuliner/widgets/smooth_star_rating.dart';

class SliderItem extends StatelessWidget {
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
  final String jamBuka;
  final String jamTutup;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;

  SliderItem(
      {Key key,
      @required this.id,
      @required this.idUser,
      this.jmlRating,
      this.jmlMenu,
      this.jmlReview,
      @required this.namaMenu,
      @required this.deskripsi,
      @required this.telepon,
      @required this.harga,
      @required this.namaTempat,
      @required this.alamat,
      @required this.jamBuka,
      @required this.jamTutup,
      @required this.img,
      @required this.isFav,
      @required this.rating,
      @required this.raters})
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
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "$img",
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
          Padding(
            padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
            child: Row(
              children: <Widget>[
                SmoothStarRating(
                  starCount: 5,
                  color: Constants.ratingBG,
                  allowHalfRating: true,
                  rating: rating,
                  size: 10.0,
                ),
                Text(
                  " $rating ($raters Reviews)",
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),
              ],
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

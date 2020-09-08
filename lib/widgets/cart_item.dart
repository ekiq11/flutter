import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/screens/details.dart';
import 'package:pdp_wisatakuliner/util/const.dart';
import 'package:pdp_wisatakuliner/widgets/smooth_star_rating.dart';

class CartItem extends StatelessWidget {
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

  CartItem(
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
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: InkWell(
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
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0.0, right: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.width / 3.5,
                width: MediaQuery.of(context).size.width / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "$img",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "$namaMenu",
                  style: TextStyle(
//                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    SmoothStarRating(
                      starCount: 1,
                      color: Constants.ratingBG,
                      allowHalfRating: true,
                      rating: 5,
                      size: 12.0,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      "5.0 (23 Reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Text(
                      "20 Pieces",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      r"$90",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  "Quantity: 1",
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

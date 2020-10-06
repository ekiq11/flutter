import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/screens/details.dart';
import 'package:pdp_wisatakuliner/util/const.dart';
import 'package:pdp_wisatakuliner/widgets/smooth_star_rating.dart';

class SliderItem extends StatefulWidget {
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

  SliderItem(
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
  _SliderItemState createState() => _SliderItemState();
}

class _SliderItemState extends State<SliderItem> {
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
                    'https://www.wisatakuapps.com/api/upload/' +
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
                      widget.isFav ? Icons.favorite : Icons.favorite_border,
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
              "${widget.namaMenu}",
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
                  rating: widget.rating,
                  size: 10.0,
                ),
                Text(
                  " ${widget.rating} (${widget.raters} Reviews)",
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
                id: widget.id,
                jmlRating: widget.jmlRating,
                jmlMenu: widget.jmlMenu,
                jmlReview: widget.jmlReview,
                idUser: widget.idUser,
                namaMenu: widget.namaMenu,
                harga: widget.harga,
                telepon: widget.telepon,
                deskripsi: widget.deskripsi,
                namaTempat: widget.namaTempat,
                alamat: widget.alamat,
                latitude: widget.latitude,
                longitude: widget.longitude,
                jamBuka: widget.jamBuka,
                jamTutup: widget.jamTutup,
                img: widget.img,
                isFav: widget.isFav,
              );
            },
          ),
        );
      },
    );
  }
}

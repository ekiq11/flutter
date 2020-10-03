import 'package:flutter/material.dart';

class GridListMenu extends StatelessWidget {
  final String idUser;
  final String namaMenu;
  final String deskripsi;
  final String harga;
  final String img;

  GridListMenu(
      {Key key,
      @required this.idUser,
      @required this.namaMenu,
      @required this.deskripsi,
      @required this.harga,
      @required this.img})
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/podo/kategori_favorit.dart';
import 'package:pdp_wisatakuliner/util/kategori_favorite.dart';
import 'package:pdp_wisatakuliner/widgets/grid_fav_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaftarMenu extends StatefulWidget {
  @override
  _DaftarMenuState createState() => _DaftarMenuState();
}

class _DaftarMenuState extends State<DaftarMenu>
    with AutomaticKeepAliveClientMixin<DaftarMenu> {
  List<Favorite> _fav;

  @override
  void initState() {
    super.initState();
    String id = "";

    getPref() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        id = preferences.getString("id");
        print(id);
        FavoriteServices.getFavorite(id).then((fav) {
          setState(() {
            _fav = fav;
          });
        });
      });
    }

    setState(() {
      getPref();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              "Daftar Menu Saya",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: _fav == null ? 0 : _fav.length,
              itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
                Favorite food = _fav[index];
//                print(foods);
//                print(foods.length);
                return GridProductDetails(
                  idMenu: food.idMenu,
                  jmlRating: food.jmlRating,
                  jmlReview: food.jmlReview,
                  jmlMenu: food.jmlMenu,
                  idUser: food.idUser,
                  img: food.img,
                  telepon: food.telepon,
                  namaTempat: food.namaTempat,
                  alamat: food.alamat,
                  jamBuka: food.jamBuka,
                  jamTutup: food.jamTutup,
                  isFav: true,
                  namaMenu: food.namaMenu,
                  harga: food.harga,
                  deskripsi: food.deskripsi,
                  rating: 5.0,
                  raters: 23,
                );
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/podo/kategori_cepat_saji.dart';
import 'package:pdp_wisatakuliner/screens/admin/categories_makanan_khas.dart';
import 'package:pdp_wisatakuliner/screens/admin/categories_screen_kue.dart';
import 'package:pdp_wisatakuliner/screens/admin/categories_screen_minuman.dart';
import 'package:pdp_wisatakuliner/screens/admin/main_screen_admin.dart';
import 'package:pdp_wisatakuliner/util/kategori_cepat_saji.dart';
import 'package:pdp_wisatakuliner/widgets/badge.dart';
import 'package:pdp_wisatakuliner/widgets/grid_product.dart';

class CategoriesCepatSaji extends StatefulWidget {
  @override
  _CategoriesCepatSajiState createState() => _CategoriesCepatSajiState();
}

class _CategoriesCepatSajiState extends State<CategoriesCepatSaji> {
  String catie = "Makanan Cepat Saji";
  List<CepatSaji> _cepatSaji;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CepatSajiServices.getCepatSaji().then((cepatSaji) {
      setState(() {
        _cepatSaji = cepatSaji;
      });
    });
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
                  return MainScreenAdmin();
                },
              ),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          "Categories",
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            SizedBox(height: 20.0),
            Container(
              height: 40.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      "Minuman",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return CategoriesScreen();
                          },
                        ),
                      );
                    },
                    color: Colors.redAccent,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      "Makanan Kue",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return CategoriesKue();
                          },
                        ),
                      );
                    },
                    color: Colors.orangeAccent,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      "Cepat Saji",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                    color: Colors.blueAccent,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      "Makanan Khas",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return CategoriesMakananKhas();
                          },
                        ),
                      );
                    },
                    color: Colors.purpleAccent,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "$catie",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            Divider(),
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
              itemCount: _cepatSaji == null ? 0 : _cepatSaji.length,
              itemBuilder: (BuildContext context, int index) {
                CepatSaji food = _cepatSaji[index];
                return GridProduct(
                  id: food.id,
                  idUser: food.idUser,
                  namaTempat: food.namaTempat,
                  alamat: food.alamat,
                  telepon: food.telepon,
                  jamBuka: food.jamBuka,
                  jamTutup: food.jamTutup,
                  img: food.img,
                  isFav: false,
                  namaMenu: food.namaMenu,
                  harga: food.harga,
                  deskripsi: food.deskripsi,
                  rating: 5.0,
                  raters: 23,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/podo/kategori_minuman_services.dart';
import 'package:pdp_wisatakuliner/screens/categories_cepat_saji.dart';
import 'package:pdp_wisatakuliner/screens/categories_makanan_khas.dart';
import 'package:pdp_wisatakuliner/screens/categories_screen_kue.dart';
import 'package:pdp_wisatakuliner/screens/main_screen.dart';
import 'package:pdp_wisatakuliner/screens/notifications.dart';
import 'package:pdp_wisatakuliner/util/kategori_minuman.dart';
import 'package:pdp_wisatakuliner/widgets/badge.dart';
import 'package:pdp_wisatakuliner/widgets/grid_product.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String catie = "Minuman";
  List<Minuman> _minuman;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MinumanServices.getMinuman().then((minuman) {
      setState(() {
        _minuman = minuman;
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
                  return MainScreen();
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
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Notifications();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
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
                    onPressed: () {},
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
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return CategoriesCepatSaji();
                          },
                        ),
                      );
                    },
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
              itemCount: _minuman == null ? 0 : _minuman.length,
              itemBuilder: (BuildContext context, int index) {
                Minuman food = _minuman[index];
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

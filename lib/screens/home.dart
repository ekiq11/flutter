import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/podo/food_services.dart';
import 'package:pdp_wisatakuliner/screens/categories_cepat_saji.dart';
import 'package:pdp_wisatakuliner/screens/categories_makanan_khas.dart';
import 'package:pdp_wisatakuliner/screens/categories_screen_kue.dart';
import 'package:pdp_wisatakuliner/screens/categories_screen_minuman.dart';
import 'package:pdp_wisatakuliner/screens/dishes.dart';
import 'package:pdp_wisatakuliner/util/tesfood.dart';
import 'package:pdp_wisatakuliner/widgets/grid_product.dart';
import 'package:pdp_wisatakuliner/widgets/slider_item.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  List<Food> _foods = [];

  @override
  void initState() {
    super.initState();

    Services.getFoods().then((foods) {
      setState(() {
        _foods = foods;
      });
    });
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  int current = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Menu Terbaru",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Selengkapnya",
                    style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return DishesScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 10.0),

            //Slider Here
            CarouselSlider(
                items: map<Widget>(
                  _foods,
                  (index, i) {
                    Food food = _foods[index];
                    return SliderItem(
                      id: food.id,
                      idUser: food.idUser,
                      telepon: food.telepon,
                      namaTempat: food.namaTempat,
                      alamat: food.alamat,
                      jamBuka: food.jamBuka,
                      jamTutup: food.jamTutup,
                      img: food.img,
                      harga: food.harga,
                      deskripsi: food.deskripsi,
                      isFav: false,
                      namaMenu: food.namaMenu,
                      rating: 5.0,
                      raters: 23,
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 1.3,
                  enlargeCenterPage: true,
                )),

            SizedBox(height: 20.0),
            Text(
              "Kategori Makanan",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Top Kuliner",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Selengkapnya",
                    style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
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
              itemCount: _foods == null ? 0 : _foods.length,
              itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
                Food food = _foods[index];
//                print(foods.length);
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

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

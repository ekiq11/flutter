import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/podo/food_services.dart';
import 'package:pdp_wisatakuliner/screens/notifications.dart';
import 'package:pdp_wisatakuliner/util/tesfood.dart';
import 'package:pdp_wisatakuliner/widgets/badge.dart';
import 'package:pdp_wisatakuliner/widgets/grid_product.dart';

class DishesScreen extends StatefulWidget {
  @override
  _DishesScreenState createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  List<Food> _foods;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Services.getFoods().then((foods) {
      setState(() {
        _foods = foods;
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
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Semua Menu",
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
            Text(
              "Terbaru",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
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
                Food food = _foods[index];
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

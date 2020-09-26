import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/podo/food_services.dart';
import 'package:pdp_wisatakuliner/util/tesfood.dart';
import 'package:pdp_wisatakuliner/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin<CartScreen> {
  List<Food> _foods;

  @override
  void initState() {
    super.initState();

    Services.getFoods().then((foods) {
      setState(() {
        _foods = foods;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView.builder(
          itemCount: _foods == null ? 0 : _foods.length,
          itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
            Food food = _foods[index];
            // print(foods);
            //   print(foods.length);
            return CartItem(
              id: food.id,
              telepon: food.telepon,
              namaTempat: food.namaTempat,
              alamat: food.alamat,
              jamBuka: food.jamBuka,
              jamTutup: food.jamTutup,
              idUser: food.idUser,
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
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Checkout",
        onPressed: () {},
        child: Icon(
          Icons.arrow_forward,
        ),
        heroTag: Object(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

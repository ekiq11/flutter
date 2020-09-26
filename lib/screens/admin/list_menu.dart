import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/podo/list_menu_services.dart';
import 'package:pdp_wisatakuliner/util/list_menu.dart';
import 'package:pdp_wisatakuliner/widgets/grid_list_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListMenu extends StatefulWidget {
  @override
  _ListMenuState createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu>
    with AutomaticKeepAliveClientMixin<ListMenu> {
  List<Menu> _listmenu;

  @override
  void initState() {
    super.initState();
    String id = "";

    getPref() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        id = preferences.getString("id");
        print(id);
        MenuServices.getList(id).then((listmenu) {
          setState(() {
            _listmenu = listmenu;
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
              "Daftar Menu",
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
              itemCount: _listmenu == null ? 0 : _listmenu.length,
              itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
                Menu food = _listmenu[index];
//                print(foods);
//                print(foods.length);
                return GridListMenu(
                  idUser: food.idUser,
                  img: food.img,
                  namaMenu: food.namaMenu,
                  harga: food.harga,
                  deskripsi: food.deskripsi,
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

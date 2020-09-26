import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/screens/details.dart';
import 'package:pdp_wisatakuliner/util/const.dart';
import 'package:pdp_wisatakuliner/util/kategori_search.dart';
import 'package:pdp_wisatakuliner/widgets/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  List<Search> _list = [];
  List<Search> _search = [];
  var loading = false;
  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    final response =
        await http.get("https://www.wisatakuapps.com/api/wisatakuApp/cari.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(Search.fromJson(i));
          loading = false;
        }
      });
    }
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.namaMenu.contains(text)) _search.add(f);
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),
          Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                controller: controller,
                onChanged: onSearch,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Search..",
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "History",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _search.length,
                  itemBuilder: (context, i) {
                    final food = _search[i];
                    return ListTile(
                      title: Text(
                        food.namaMenu,
                        style: TextStyle(
//                    fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          food.img,
                        ),
                      ),
                      trailing: Text("Rp." + food.harga),
                      subtitle: Row(
                        children: <Widget>[
                          SmoothStarRating(
                            starCount: 5,
                            color: Constants.ratingBG,
                            allowHalfRating: true,
                            rating: 5.0,
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
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ProductDetails(
                                id: food.id,
                                idUser: food.idUser,
                                namaMenu: food.namaMenu,
                                namaTempat: food.namaTempat,
                                alamat: food.alamat,
                                jamBuka: food.jamBuka,
                                jamTutup: food.jamTutup,
                                harga: food.harga,
                                telepon: food.telepon,
                                deskripsi: food.deskripsi,
                                img: food.img,
                                isFav: false,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

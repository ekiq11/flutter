// To parse this JSON data, do
//
//     final favorite = favoriteFromJson(jsonString);

import 'dart:convert';

List<Favorite> favoriteFromJson(String str) =>
    List<Favorite>.from(json.decode(str).map((x) => Favorite.fromJson(x)));

String favoriteToJson(List<Favorite> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favorite {
  Favorite({
    this.namaMenu,
    this.img,
    this.harga,
    this.deskripsi,
    this.namaTempat,
    this.alamat,
    this.telepon,
    this.jamBuka,
    this.jamTutup,
    this.id,
    this.idUser,
    this.idMenu,
    this.isFav,
    this.jmlRating,
    this.jmlReview,
    this.jmlMenu,
  });

  String namaMenu;
  String jmlRating;
  String jmlReview;
  String jmlMenu;
  String img;
  String harga;
  String deskripsi;
  String namaTempat;
  String alamat;
  String telepon;
  String jamBuka;
  String jamTutup;
  String id;
  String idUser;
  String idMenu;
  String isFav;

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        namaMenu: json["namaMenu"],
        img: json["img"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        namaTempat: json["namaTempat"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        jamBuka: json["jamBuka"],
        jamTutup: json["jamTutup"],
        id: json["id"],
        idUser: json["idUser"],
        idMenu: json["idMenu"],
        isFav: json["isFav"],
      );

  Map<String, dynamic> toJson() => {
        "namaMenu": namaMenu,
        "img": img,
        "harga": harga,
        "deskripsi": deskripsi,
        "namaTempat": namaTempat,
        "alamat": alamat,
        "telepon": telepon,
        "jamBuka": jamBuka,
        "jamTutup": jamTutup,
        "id": id,
        "idUser": idUser,
        "idMenu": idMenu,
        "isFav": isFav,
      };
}

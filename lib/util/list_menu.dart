// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

List<Menu> menuFromJson(String str) =>
    List<Menu>.from(json.decode(str).map((x) => Menu.fromJson(x)));

String menuToJson(List<Menu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Menu {
  Menu({
    this.id,
    this.namaMenu,
    this.deskripsi,
    this.harga,
    this.tanggalinput,
    this.img,
    this.idUser,
    this.idKuliner,
    this.idKategoriMenu,
  });

  String id;
  String namaMenu;
  String deskripsi;
  String harga;
  DateTime tanggalinput;
  String img;
  String idUser;
  String idKuliner;
  String idKategoriMenu;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        namaMenu: json["namaMenu"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        tanggalinput: DateTime.parse(json["tanggalinput"]),
        img: json["img"],
        idUser: json["idUser"],
        idKuliner: json["idKuliner"],
        idKategoriMenu: json["idKategoriMenu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "namaMenu": namaMenu,
        "deskripsi": deskripsi,
        "harga": harga,
        "tanggalinput": tanggalinput.toIso8601String(),
        "img": img,
        "idUser": idUser,
        "idKuliner": idKuliner,
        "idKategoriMenu": idKategoriMenu,
      };
}

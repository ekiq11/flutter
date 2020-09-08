// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

List<Search> searchFromJson(String str) =>
    List<Search>.from(json.decode(str).map((x) => Search.fromJson(x)));

String searchToJson(List<Search> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Search {
  Search({
    this.id,
    this.namaMenu,
    this.deskripsi,
    this.harga,
    this.tanggalinput,
    this.img,
    this.idUser,
    this.idKuliner,
    this.idKategoriMenu,
    this.namaTempat,
    this.alamat,
    this.telepon,
    this.jamBuka,
    this.jamTutup,
  });

  String id;
  String namaMenu;
  String deskripsi;
  String harga;
  String tanggalinput;
  String img;
  String idUser;
  String idKuliner;
  String idKategoriMenu;
  String namaTempat;
  String alamat;
  String telepon;
  String jamBuka;
  String jamTutup;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        id: json["id"],
        namaMenu: json["namaMenu"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        tanggalinput: json["tanggalinput"],
        img: json["img"],
        idUser: json["idUser"],
        idKuliner: json["idKuliner"],
        idKategoriMenu: json["idKategoriMenu"],
        namaTempat: json["namaTempat"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        jamBuka: json["jamBuka"],
        jamTutup: json["jamTutup"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "namaMenu": namaMenu,
        "deskripsi": deskripsi,
        "harga": harga,
        "tanggalinput": tanggalinput.toString(),
        "img": img,
        "idUser": idUser,
        "idKuliner": idKuliner,
        "idKategoriMenu": idKategoriMenu,
        "namaTempat": namaTempat,
        "alamat": alamat,
        "telepon": telepon,
        "jamBuka": jamBuka,
        "jamTutup": jamTutup,
      };
}

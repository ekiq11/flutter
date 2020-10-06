// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

List<Food> foodFromJson(String str) =>
    List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
  Food({
    this.id,
    this.idUser,
    this.namaMenu,
    this.deskripsi,
    this.harga,
    this.tanggalinput,
    this.img,
    this.nama,
    this.namaTempat,
    this.alamat,
    this.telepon,
    this.latitude,
    this.longitude,
    this.jamBuka,
    this.jamTutup,
  });

  String id;
  String idUser;
  String namaMenu;
  String deskripsi;
  String harga;
  String tanggalinput;
  String img;
  String nama;
  String namaTempat;
  String alamat;
  String telepon;
  String latitude;
  String longitude;
  String jamBuka;
  String jamTutup;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        idUser: json["idUser"],
        namaMenu: json["namaMenu"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        tanggalinput: json["tanggalinput"],
        img: json["img"],
        nama: json["nama"],
        namaTempat: json["namaTempat"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        jamBuka: json["jamBuka"],
        jamTutup: json["jamTutup"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "namaMenu": namaMenu,
        "deskripsi": deskripsi,
        "harga": harga,
        "tanggalinput": tanggalinput.toString(),
        "img": img,
        "nama": nama,
        "namaTempat": namaTempat,
        "alamat": alamat,
        "telepon": telepon,
        "latitude": latitude,
        "longitude": longitude,
        "jamBuka": jamBuka,
        "jamTutup": jamTutup,
      };
}

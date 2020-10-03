// To parse this JSON data, do
//
//     final maps = mapsFromJson(jsonString);

import 'dart:convert';

List<Maps> mapsFromJson(String str) =>
    List<Maps>.from(json.decode(str).map((x) => Maps.fromJson(x)));

String mapsToJson(List<Maps> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Maps {
  Maps({
    this.id,
    this.idUser,
    this.namaMenu,
    this.deskripsi,
    this.harga,
    this.tanggalinput,
    this.img,
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
  DateTime tanggalinput;
  String img;
  String namaTempat;
  String alamat;
  String telepon;
  double latitude;
  double longitude;
  String jamBuka;
  String jamTutup;

  factory Maps.fromJson(Map<String, dynamic> json) => Maps(
        id: json["id"],
        idUser: json["idUser"],
        namaMenu: json["namaMenu"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        tanggalinput: DateTime.parse(json["tanggalinput"]),
        img: json["img"],
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
        "tanggalinput": tanggalinput.toIso8601String(),
        "img": img,
        "namaTempat": namaTempat,
        "alamat": alamat,
        "telepon": telepon,
        "latitude": latitude,
        "longitude": longitude,
        "jamBuka": jamBuka,
        "jamTutup": jamTutup,
      };
}

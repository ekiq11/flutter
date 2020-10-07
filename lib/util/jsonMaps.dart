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
    this.namaTempat,
    this.alamat,
    this.telepon,
    this.latitude,
    this.longitude,
    this.jamBuka,
    this.jamTutup,
    this.idWialayah,
    this.idUser,
    this.img,
  });

  String id;
  String namaTempat;
  String alamat;
  String telepon;
  String latitude;
  String longitude;
  String jamBuka;
  String jamTutup;
  String idWialayah;
  String idUser;
  String img;

  factory Maps.fromJson(Map<String, dynamic> json) => Maps(
        id: json["id"],
        namaTempat: json["namaTempat"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        jamBuka: json["jamBuka"],
        jamTutup: json["jamTutup"],
        idWialayah: json["idWialayah"],
        idUser: json["idUser"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "namaTempat": namaTempat,
        "alamat": alamat,
        "telepon": telepon,
        "latitude": latitude,
        "longitude": longitude,
        "jamBuka": jamBuka,
        "jamTutup": jamTutup,
        "idWialayah": idWialayah,
        "idUser": idUser,
        "img": img,
      };
}

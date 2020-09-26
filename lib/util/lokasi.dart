// To parse this JSON data, do
//
//     final lokasi = lokasiFromJson(jsonString);

import 'dart:convert';

List<Lokasi> lokasiFromJson(String str) =>
    List<Lokasi>.from(json.decode(str).map((x) => Lokasi.fromJson(x)));

String lokasiToJson(List<Lokasi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Lokasi {
  Lokasi({
    this.id,
    this.namaTempat,
    this.alamat,
    this.telepon,
    this.latitude,
    this.longitude,
    this.jamBuka,
    this.jamTutup,
    this.img,
    this.idWialayah,
    this.idUser,
  });

  String id;
  String namaTempat;
  String alamat;
  String telepon;
  String latitude;
  String longitude;
  String jamBuka;
  String jamTutup;
  String img;
  String idWialayah;
  String idUser;

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
        id: json["id"],
        namaTempat: json["namaTempat"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        jamBuka: json["jamBuka"],
        jamTutup: json["jamTutup"],
        img: json["img"],
        idWialayah: json["idWialayah"],
        idUser: json["idUser"],
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
        "img": img,
        "idWialayah": idWialayah,
        "idUser": idUser,
      };
}

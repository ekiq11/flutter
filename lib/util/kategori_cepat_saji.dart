// To parse this JSON data, do
//
//     final cepatSaji = cepatSajiFromJson(jsonString);

import 'dart:convert';

List<CepatSaji> cepatSajiFromJson(String str) =>
    List<CepatSaji>.from(json.decode(str).map((x) => CepatSaji.fromJson(x)));

String cepatSajiToJson(List<CepatSaji> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CepatSaji {
  CepatSaji({
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
  String nama;
  String namaTempat;
  String alamat;
  String telepon;
  String jamBuka;
  String jamTutup;

  factory CepatSaji.fromJson(Map<String, dynamic> json) => CepatSaji(
        id: json["id"],
        idUser: json["idUser"],
        namaMenu: json["namaMenu"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        tanggalinput: DateTime.parse(json["tanggalinput"]),
        img: json["img"],
        nama: json["nama"],
        namaTempat: json["namaTempat"],
        alamat: json["alamat"],
        telepon: json["telepon"],
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
        "nama": nama,
        "namaTempat": namaTempat,
        "alamat": alamat,
        "telepon": telepon,
        "jamBuka": jamBuka,
        "jamTutup": jamTutup,
      };
}

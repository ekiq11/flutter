// To parse this JSON data, do
//
//     final komentar = komentarFromJson(jsonString);

import 'dart:convert';

List<Komentar> komentarFromJson(String str) =>
    List<Komentar>.from(json.decode(str).map((x) => Komentar.fromJson(x)));

String komentarToJson(List<Komentar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Komentar {
  Komentar({
    this.jmlRating,
    this.jmlReview,
    this.id,
    this.komentar,
    this.rating,
    this.tglKomentar,
    this.idMenu,
    this.idUser,
    this.jmlMenu,
    this.nama,
    this.img,
  });

  String jmlRating;
  String jmlReview;
  String id;
  String komentar;
  String rating;
  String tglKomentar;
  String idMenu;
  String idUser;
  String jmlMenu;
  String nama;
  String img;

  factory Komentar.fromJson(Map<String, dynamic> json) => Komentar(
        jmlRating: json["jml_rating"],
        jmlReview: json["jml_review"],
        id: json["id"],
        komentar: json["komentar"],
        rating: json["rating"],
        tglKomentar: json["tglKomentar"],
        idMenu: json["idMenu"],
        idUser: json["idUser"],
        jmlMenu: json["jml_menu"],
        nama: json["nama"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "jml_rating": jmlRating,
        "jml_review": jmlReview,
        "id": id,
        "komentar": komentar,
        "rating": rating,
        "tglKomentar": tglKomentar.toString(),
        "idMenu": idMenu,
        "idUser": idUser,
        "jml_menu": jmlMenu,
        "nama": nama,
        "img": img,
      };
}

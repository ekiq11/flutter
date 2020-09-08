// To parse this JSON data, do
//
//     final rating = ratingFromJson(jsonString);

import 'dart:convert';

List<Rating> ratingFromJson(String str) =>
    List<Rating>.from(json.decode(str).map((x) => Rating.fromJson(x)));

String ratingToJson(List<Rating> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rating {
  Rating({
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
  DateTime tglKomentar;
  String idMenu;
  String idUser;
  String jmlMenu;
  String nama;
  String img;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        jmlRating: json["jmlRating"],
        jmlReview: json["jmlReview"],
        id: json["id"],
        komentar: json["komentar"],
        rating: json["rating"],
        tglKomentar: DateTime.parse(json["tglKomentar"]),
        idMenu: json["idMenu"],
        idUser: json["idUser"],
        jmlMenu: json["jmlMenu"],
        nama: json["nama"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "jmlRating": jmlRating,
        "jmlReview": jmlReview,
        "id": id,
        "komentar": komentar,
        "rating": rating,
        "tglKomentar": tglKomentar.toIso8601String(),
        "idMenu": idMenu,
        "idUser": idUser,
        "jmlMenu": jmlMenu,
        "nama": nama,
        "img": img,
      };
}

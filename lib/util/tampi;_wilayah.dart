// To parse this JSON data, do
//
//     final wilayah = wilayahFromJson(jsonString);

import 'dart:convert';

List<Wilayah> wilayahFromJson(String str) =>
    List<Wilayah>.from(json.decode(str).map((x) => Wilayah.fromJson(x)));

String wilayahToJson(List<Wilayah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Wilayah {
  Wilayah({
    this.id,
    this.namaWilayah,
  });

  String id;
  String namaWilayah;

  factory Wilayah.fromJson(Map<String, dynamic> json) => Wilayah(
        id: json["id"],
        namaWilayah: json["namaWilayah"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "namaWilayah": namaWilayah,
      };
}

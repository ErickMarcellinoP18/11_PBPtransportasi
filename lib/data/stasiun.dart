import 'dart:convert';

class Stasiun {
  // benerin ini jangan lupa
  final String? id;

  String? nama, kota;

  Stasiun({required this.id, required this.nama, required this.kota});

  factory Stasiun.fromRawJson(String str) => Stasiun.fromJson(json.decode(str));
  factory Stasiun.fromJson(Map<String, dynamic> json) => Stasiun(
        id: json["kode"].toString(),
        nama: json["nama"],
        kota: json["kota"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "kode": id,
        "nama": nama,
        "kota": kota,
      };
}

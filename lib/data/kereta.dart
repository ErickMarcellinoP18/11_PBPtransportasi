import 'dart:convert';

class Kereta {
  // benerin ini jangan lupa
  final String? kode;

  String? nama;
  int kapasitas, rating;

  Kereta(
      {required this.kode,
      required this.nama,
      required this.kapasitas,
      required this.rating});

  factory Kereta.fromRawJson(String str) => Kereta.fromJson(json.decode(str));
  factory Kereta.fromJson(Map<String, dynamic> json) => Kereta(
        kode: json["kode"].toString(),
        nama: json["nama"],
        kapasitas: json["kapasitas"],
        rating: json["rating"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "kode": kode,
        "nama": nama,
        "kapasitas": kapasitas,
        "rating": rating,
      };
}

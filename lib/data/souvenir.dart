import 'dart:convert';

class Souvenir {
  // benerin ini jangan lupa
  final int? id;
  int? berat, harga;
  String? nama;

  Souvenir(
      {required this.id,
      required this.nama,
      required this.berat,
      required this.harga});

  factory Souvenir.fromRawJson(String str) =>
      Souvenir.fromJson(json.decode(str));
  factory Souvenir.fromJson(Map<String, dynamic> json) => Souvenir(
        id: json["id"],
        nama: json["nama"],
        berat: json["berat"],
        harga: json["harga"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "berat": berat,
        "harga": harga,
      };
}

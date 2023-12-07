import 'dart:convert';

class Transaksi {
  // benerin ini jangan lupa
  final int? id;
  int? id_user, id_souvenir;
  int? jumlah;
  String? status;

  Transaksi({
    required this.id,
    required this.id_user,
    required this.id_souvenir,
    required this.jumlah,
    required this.status,
  });

  factory Transaksi.fromRawJson(String str) =>
      Transaksi.fromJson(json.decode(str));
  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json["id"],
        id_user: json["id_user"],
        id_souvenir: json["id_souvenir"],
        jumlah: json["jumlah"],
        status: json["status"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": id_user,
        "id_souvenir": id_souvenir,
        "jumlah": jumlah,
        "status": status,
      };
}

import 'dart:convert';

class ticket {
  final int? IdTicket;

  String? tujuan, asal, jenis;
  int? harga;

  ticket(
      {required this.IdTicket,
      required this.asal,
      required this.tujuan,
      required this.harga,
      required this.jenis});

  factory ticket.fromRawJson(String str) => ticket.fromJson(json.decode(str));
  factory ticket.fromJson(Map<String, dynamic> json) => ticket(
        IdTicket: json["id"],
        asal: json["dari"],
        tujuan: json["ke"],
        harga: json["jumlah"],
        jenis: json["kelas"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": IdTicket,
        "dari": asal,
        "ke": tujuan,
        "jumlah": harga,
        "kelas": jenis,
      };
}

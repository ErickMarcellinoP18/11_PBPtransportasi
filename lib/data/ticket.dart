import 'dart:convert';

class ticket {
  final int? IdTicket;
  int? id_user, id_jadwal;
  String? id_kereta;
  String? tujuan, asal, status;
  int? jumlah;
  DateTime? tanggal_pergi;

  ticket({
    required this.IdTicket,
    required this.id_user,
    required this.id_jadwal,
    required this.id_kereta,
    required this.asal,
    required this.tujuan,
    required this.jumlah,
    required this.status,
    required this.tanggal_pergi,
  });

  factory ticket.fromRawJson(String str) => ticket.fromJson(json.decode(str));
  factory ticket.fromJson(Map<String, dynamic> json) => ticket(
      IdTicket: json["id"],
      id_user: json["id_user"],
      id_jadwal: json["id_jadwal"],
      id_kereta: json["id_kereta"],
      asal: json["dari"],
      tujuan: json["ke"],
      jumlah: json["jumlah"],
      status: json["status"],
      tanggal_pergi: DateTime.parse(json["tanggal_pergi"]));

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": IdTicket,
        "dari": asal,
        "ke": tujuan,
        "jumlah": jumlah,
        "status": status,
      };
}

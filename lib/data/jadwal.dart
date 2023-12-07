import 'dart:convert';

import 'package:intl/intl.dart';

class Jadwal {
  final int? idJadwal;
  int? harga, kursi;
  int status, rating;
  String idKereta, berangkat, tiba;
  String namaKereta;
  DateTime tanggal, jam_berangkat, jam_tiba;

  Jadwal(
      {required this.idJadwal,
      required this.idKereta,
      required this.tanggal,
      required this.harga,
      required this.berangkat,
      required this.tiba,
      required this.status,
      required this.kursi,
      required this.rating,
      required this.namaKereta,
      required this.jam_berangkat,
      required this.jam_tiba});

  factory Jadwal.fromRawJson(String str) => Jadwal.fromJson(json.decode(str));
  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        idJadwal: json["id"],
        idKereta: json["id_kereta"],
        harga: json["harga"],
        berangkat: json["berangkat"],
        tiba: json["tiba"],
        namaKereta: json["nama"],
        status: json["status"],
        rating: json["rating"],
        kursi: json["kursi"],
        tanggal: DateTime.parse(json['tanggal']),
        jam_berangkat: DateFormat('HH:mm:ss').parse(json['jam_berangkat']),
        jam_tiba: DateFormat('HH:mm:ss').parse(json['jam_tiba']),
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": idJadwal,
        "id_kereta": idKereta,
        "harga": harga,
        "berangkat": berangkat,
        "tiba": tiba,
        "status": status,
        "rating": rating,
        "nama": namaKereta,
        "kursi": kursi,
        'tanggal': tanggal.toIso8601String(),
        'jam_berangkat': DateFormat('HH:mm:ss').format(jam_berangkat),
        'jam_tiba': DateFormat('HH:mm:ss').format(jam_tiba),
      };
}

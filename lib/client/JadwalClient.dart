import 'package:transportasi_11/data/Jadwal.dart';

import 'dart:convert';
import 'package:http/http.dart';

class JadwalClient {
  static final String url = '127.0.0.1:8000';
  static final String endpoint = '/api/showJadwal';

  static Future<List<Jadwal>> find(String dari, String ke, DateTime tgl) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$dari/$ke/$tgl'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Jadwal.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}

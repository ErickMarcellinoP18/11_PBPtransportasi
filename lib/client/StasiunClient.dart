import 'package:transportasi_11/data/stasiun.dart';

import 'dart:convert';
import 'package:http/http.dart';

class stasiunClient {
  static final String url = '20.255.52.134:8000';
  static final String endpoint = '/api/all';

  static Future<List<Stasiun>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Stasiun.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}

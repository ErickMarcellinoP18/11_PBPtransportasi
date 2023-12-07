import 'package:transportasi_11/data/souvenir.dart';

import 'dart:convert';
import 'package:http/http.dart';

class SouvenirClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/allSouve';

  static Future<List<Souvenir>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Souvenir.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}

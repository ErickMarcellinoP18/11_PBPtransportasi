import 'package:transportasi_11/data/review.dart';

import 'dart:convert';
import 'package:http/http.dart';

class ReviewClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/review';

  static Future<List<Review>> fetchByKereta(kode) async {
    try {
      var response = await get(Uri.http(url, "/api/reviewByKereta/${kode}"));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Review.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Review> fetchByKeretaUser(kode, id) async {
    try {
      var response = await get(Uri.http(url, "/api/reviewUser/$kode/$id"));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return Review.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Review> find(id) async {
    try {
      var response = await get(Uri.http("10.0.2.2:8000", '$endpoint/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return Review.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Review review) async {
    try {
      var response = await post(Uri.http("10.0.2.2:8000", endpoint),
          headers: {"Content-Type": "application/json"},
          body: review.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Review review) async {
    try {
      var response = await put(
          Uri.http("10.0.2.2:8000", '$endpoint/${review.id}'),
          headers: {"Content-Type": "application/json"},
          body: review.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http("10.0.2.2:8000", '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}

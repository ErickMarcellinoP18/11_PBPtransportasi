import 'package:transportasi_11/data/ticket.dart';

import 'dart:convert';
import 'package:http/http.dart';

class ticketClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/tiket';

  static Future<List<ticket>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => ticket.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<ticket> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return ticket.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<ticket>> findByUser(idUser) async {
    try {
      var response = await get(Uri.http(url, '/api/tiketShow/$idUser'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => ticket.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(ticket ticket) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-type": "application/json"},
          body: ticket.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(ticket ticket) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${ticket.IdTicket}'),
          headers: {"Content-type": "application/json"},
          body: ticket.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}

import 'package:transportasi_11/data/user.dart';

import 'dart:convert';
import 'package:http/http.dart';

class userClient {
  static final String url = '20.255.52.134:8000';
  static final String endpoint = '/api/User';
  //janlup ganti ini kalo perlu ganti

  static Future<List<User>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(User user) async {
    try {
      print(Uri.http(url, endpoint));
      print(user.toRawJson());
      print("User ID in JSON: ${user.toJson()['profilePicture']}");
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(User user) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${user.id}'),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User> Login(String username, String password) async {
    try {
      var response = await post(Uri.http(url, "/api/login"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"username": username, "password": password}));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> ResetPass(String username, String newPass) async {
    try {
      var response = await post(Uri.http(url, "/api/resetPassword"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"username": username, "password": newPass}));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<LoginModel?> logintesting({
    required String username,
    required String password,
  }) async {
    String uri = '127.0.0.1:8000';

    try {
      var apiResult = await post(Uri.http(uri, "/api/login"),
          body: jsonEncode({"username": username, "password": password}));
      if (apiResult.statusCode == 200) {
        final result = LoginModel.fromRawJson(apiResult.body);
        return result;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}

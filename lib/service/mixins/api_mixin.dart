import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

mixin ApiMixin<T> {
  Future<T> fetchData({
    required String endPoint,
    String? token,
    Map<String, dynamic>? query,
    dynamic body,
    bool patch = false,
  }) async {
    final headers = {
      'Accept': 'application/json',
      if (body is String || body == null) 'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };

    final client = http.Client();
    try {
      http.Response response;
      if (body == null) {
        if (query != null) {
          for (final e in query.entries) {
            endPoint += query.entries.first.key == e.key ? '?' : '&';
            if (e.value is List) {
              endPoint += e.value.map((x) => '${e.key}=$x').toList().join('&');
            } else {
              endPoint += '${e.key}=${e.value}';
            }
          }
        }
        response = await client
            .get(Uri.parse(endPoint), headers: headers)
            .timeout(const Duration(seconds: 12));
      } else {
        if (patch) {
          response = await client
              .patch(Uri.parse(endPoint), headers: headers, body: body)
              .timeout(const Duration(seconds: 12));
        } else {
          response = await client
              .post(Uri.parse(endPoint), headers: headers, body: body)
              .timeout(const Duration(seconds: 12));
        }
      }

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseBody;
      }

      throw Exception('${response.statusCode}: ${responseBody['message']}');
    } on TimeoutException catch (_) {
      throw Exception('The request time out.');
    } on SocketException catch (_) {
      throw Exception('Network Connection Exception');
    } on Exception catch (e) {
      print(e.toString());
      rethrow;
    } finally {
      client.close();
    }
  }
}

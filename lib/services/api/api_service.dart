import 'dart:convert';

import 'package:http/http.dart' as http;

enum HTTPMethod { GET, POST, PUT, DELETE }

class ApiService {
  static Future<Map<String, dynamic>> sendRequest({
    required String url,
    required HTTPMethod method,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      String jsonBody = json.encode(body);

      // now we have a valid url and a nice json string

      http.Request request = http.Request(method.name, uri);

      if (method == HTTPMethod.POST && body == null) {
        throw Exception('Body is required for POST requests');
      }
      request.headers['Content-Type'] = 'application/json';

      if (body != null) {
        request.body = jsonBody;
      }

      http.StreamedResponse response = await request.send();

      // Check the status code of the response is in the range of 200
      if ((response.statusCode < 200 || response.statusCode >= 300)) {
        throw Exception('Request failed with status: ${response.statusCode}');
      }

      var responseBody = await response.stream.bytesToString();

      var decodedBody = json.decode(responseBody);

      if (decodedBody is Map<String, dynamic>) {
        return decodedBody;
      } else {
        return {
          'data': decodedBody,
        };
      }

      // Send request to server
    } catch (e) {
      print(e);

      rethrow;
      // Handle error
    }
  }
}

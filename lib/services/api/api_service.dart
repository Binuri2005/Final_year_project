import 'dart:convert';
import 'dart:io';

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
        throw ApiError(
          'Body is required for POST requests',
          type: ApiErrorType.BODY_REQUIRED,
        );
      }
      request.headers['Content-Type'] = 'application/json';

      if (body != null) {
        request.body = jsonBody;
      }

      http.StreamedResponse response = await request.send();
      var responseBody = await response.stream.bytesToString();

      var decodedBody = json.decode(responseBody);

      // Check the status code of the response is in the range of 200
      if ((response.statusCode < 200 || response.statusCode >= 300)) {
        String errorMessage = decodedBody['message'].runtimeType == List
            ? decodedBody['message'][0]
            : decodedBody['message'].toString();
        throw ApiError(
          errorMessage,
          type: ApiError.getAPIErrorEnumFromStatusCode(response.statusCode),
        );
      }

      if (decodedBody is Map<String, dynamic>) {
        return decodedBody;
      } else {
        return {
          'data': decodedBody,
        };
      }

      // Send request to server
    } on SocketException catch (e) {
      throw ApiError('Network error: $e', type: ApiErrorType.NETWORK);
    } catch (e) {
      print(e);

      rethrow;
      // Handle error
    }
  }
}

enum ApiErrorType {
  NETWORK,
  SERVER,
  UNAUTHORIZED,
  BAD_REQUEST,
  NOT_FOUND,
  FILE_TOO_LARGE,

  BODY_REQUIRED,

  UNKNOWN,
}

class ApiError extends Error {
  final String message;

  final ApiErrorType type;

  ApiError(this.message, {this.type = ApiErrorType.UNKNOWN});

  @override
  String toString() {
    return message;
  }

  static ApiErrorType getAPIErrorEnumFromStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return ApiErrorType.BAD_REQUEST;
      case 401:
        return ApiErrorType.UNAUTHORIZED;
      case 404:
        return ApiErrorType.NOT_FOUND;
      case 413:
        return ApiErrorType.FILE_TOO_LARGE;

      default:
        return ApiErrorType.UNKNOWN;
    }
  }
}

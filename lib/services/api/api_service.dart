import 'dart:convert';
import 'dart:io';

import 'package:app/services/storage/storage.service.dart';
import 'package:http/http.dart' as http;

enum HTTPMethod { GET, POST, PUT, DELETE }

class ApiService {
  static Future<Map<String, dynamic>> sendRequest({
    required String url,
    required HTTPMethod method,
    Map<String, dynamic>? body,
  }) async {
    try {
      print("[ApiService] Sending ${method.name} request to: $url");
      Uri uri = Uri.parse(url);

      String jsonBody = json.encode(body);
      print("[ApiService] Request body: $jsonBody");

      http.Request request = http.Request(method.name, uri);

      if (method == HTTPMethod.POST && body == null) {
        throw ApiError(
          'Body is required for POST requests',
          type: ApiErrorType.BODY_REQUIRED,
        );
      }
      request.headers['Content-Type'] = 'application/json';

      var token = await SecureStorageService().read("access_token");

      if (token != null) {
        request.headers['Authorization'] = "Bearer $token";
        print("[ApiService] Using token for authorization");
      }

      if (body != null) {
        request.body = jsonBody;
      }

      print("[ApiService] Sending request...");
      http.StreamedResponse response = await request.send();
      var responseBody = await response.stream.bytesToString();
      print("[ApiService] Response received: ${response.statusCode}");

      var decodedBody = json.decode(responseBody);
      print("[ApiService] Decoded response body: $decodedBody");

      // Check the status code of the response is in the range of 200
      if ((response.statusCode < 200 || response.statusCode >= 300)) {
        String errorMessage = decodedBody['message'].runtimeType == List
            ? decodedBody['message'][0]
            : decodedBody['message'].toString();
        print("[ApiService] API Error: $errorMessage");
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
    } on SocketException catch (e) {
      print("[ApiService] Network error: $e");
      throw ApiError('Network error: $e', type: ApiErrorType.NETWORK);
    } catch (e) {
      print("[ApiService] Unknown error: $e");
      rethrow;
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
    return "[ApiError] $message";
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

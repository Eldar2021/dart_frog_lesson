import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

typedef FromJson<T> = T Function(Map<String, dynamic>);

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<(T?, String status)> get<T>(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await _client.get(uri, headers: header);
      if (response.statusCode != HttpStatus.ok) {
        return (null, '${response.statusCode}');
      }
      return (response.decode<T>(), '${response.statusCode}');
    } catch (e, s) {
      return (null, s.toString());
    }
  }

  Future<(String? success, String status)> post<T>(String url, Map<String, dynamic> body) async {
    try {
      final uri = Uri.parse(url);
      final response = await _client.post(uri, headers: header, body: jsonEncode(body));
      if (response.statusCode != HttpStatus.ok && response.statusCode != HttpStatus.created) {
        return (null, '${response.statusCode}');
      }
      return ('Success', response.statusCode.toString());
    } catch (e, s) {
      return (null, s.toString());
    }
  }

  Future<(T?, String status)> getType<T>(String url, {required FromJson<T> fromJson}) async {
    try {
      final (data, status) = await get<Map<String, dynamic>>(url);
      return data != null ? (fromJson(data), status) : (null, status);
    } catch (e, s) {
      throw JsonDeserializationException(error: e, stackTrace: s);
    }
  }

  Future<(List<T>?, String status)> getTypeList<T>(String url, {required FromJson<T> fromJson}) async {
    try {
      final (data, status) = await get<List<dynamic>>(url);
      if (data == null) return (null, status);
      return (data.map((e) => fromJson(e as Map<String, dynamic>)).toList(), status);
    } catch (e, s) {
      throw JsonDeserializationException(error: e, stackTrace: s);
    }
  }

  static final header = <String, String>{
    HttpHeaders.contentTypeHeader: ContentType.json.value,
    HttpHeaders.acceptHeader: ContentType.json.value,
  };
}

extension on http.Response {
  T decode<T>() {
    try {
      return jsonDecode(body) as T;
    } catch (e, s) {
      throw JsonDecodeException(error: e, stackTrace: s);
    }
  }
}

class HttpRequestException implements Exception {
  const HttpRequestException({this.error, this.stackTrace, this.statusCode});

  final dynamic error;
  final StackTrace? stackTrace;
  final int? statusCode;
}

class JsonDecodeException implements Exception {
  const JsonDecodeException({this.error, this.stackTrace});

  final dynamic error;
  final StackTrace? stackTrace;
}

class JsonDeserializationException implements Exception {
  const JsonDeserializationException({this.error, this.stackTrace});

  final dynamic error;
  final StackTrace? stackTrace;
}

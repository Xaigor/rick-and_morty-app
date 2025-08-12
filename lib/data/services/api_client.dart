import 'dart:convert';

abstract class ApiClient {
  Future<dynamic> get(String path,
      {Map<String, String>? headers, Map<String, dynamic>? query});
  Future<dynamic> post(String path,
      {Map<String, String>? headers, Object? body});
}

/// Utilitário simples para codificar corpo em JSON quando necessário.
String encodeJson(Object? body) => body is String ? body : jsonEncode(body);

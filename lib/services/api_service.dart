import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ApiService {
  final http.Client _client;
  final String _baseUrl;

  ApiService({
    http.Client? client,
    String? baseUrl,
  })  : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? _defaultBaseUrl;

  // Physical device: use Mac's local WiFi IP
  // Android emulator: use 10.0.2.2 (alias for host)
  // iOS simulator / desktop: use localhost
  static const String _host = '192.168.1.167';
  static String get _defaultBaseUrl => 'http://$_host:8080';

  Future<Product> fetchProduct(String barcode) async {
    final url = '$_baseUrl/api/products/$barcode';
    print('ApiService: fetching $url');

    final response = await _client
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return Product.fromJson(json);
    } else if (response.statusCode == 404) {
      throw ProductNotFoundException(barcode);
    } else {
      throw ApiException('Server error: ${response.statusCode}');
    }
  }

  void dispose() {
    _client.close();
  }
}

class ProductNotFoundException implements Exception {
  final String barcode;
  const ProductNotFoundException(this.barcode);

  @override
  String toString() => 'Product not found for barcode: $barcode';
}

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

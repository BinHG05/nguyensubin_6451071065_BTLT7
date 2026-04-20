import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/api_constants.dart';
import '../models/product_model.dart';
import 'dart:async';

class ApiService {
  Future<List<Product>> searchProducts(String keyword) async {
    if (keyword.isEmpty) return [];
    
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.searchEndpoint}?q=$keyword');
    final response = await http.get(
      url,
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List productsJson = jsonResponse['products'];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Tìm kiếm thất bại (${response.statusCode}): ${response.reasonPhrase}');
    }
  }
}

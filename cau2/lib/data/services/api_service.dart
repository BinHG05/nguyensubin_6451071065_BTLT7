import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/api_constants.dart';
import '../models/product_model.dart';

class ApiService {
  Future<Product> fetchProductDetail(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'Flutter',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Product.fromJson(jsonResponse);
      } else {
        throw Exception('Lỗi hệ thống (Status code: ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('Không có mạng. Kiểm tra lại kết nối!');
    } catch (e) {
      throw Exception('Đã xảy ra lỗi: $e');
    }
  }
}

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/api_constants.dart';
import '../models/user_model.dart';

class ApiService {
  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'PostmanRuntime/7.37.0', // Giả lập User-Agent phổ biến
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((user) => User.fromJson(user)).toList();
      } else {
        throw Exception('Lỗi hệ thống (Status code: ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('Không có kết nối Internet. Vui lòng kiểm tra lại mạng.');
    } catch (e) {
      throw Exception('Đã xảy ra lỗi: $e');
    }
  }
}

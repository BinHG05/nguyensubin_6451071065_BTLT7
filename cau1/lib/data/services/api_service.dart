import 'dart:convert';
import 'dart:io';

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
          'User-Agent': 'PostmanRuntime/7.37.0',
        },
      );

      if (response.statusCode == 200) {
        final List jsonResponse = json.decode(response.body);
        return jsonResponse.map((user) => User.fromJson(user)).toList();
      }

      throw Exception('Loi he thong (Status code: ${response.statusCode})');
    } on SocketException {
      throw Exception('Khong co ket noi Internet. Vui long kiem tra lai mang.');
    } catch (e) {
      throw Exception('Da xay ra loi: $e');
    }
  }
}

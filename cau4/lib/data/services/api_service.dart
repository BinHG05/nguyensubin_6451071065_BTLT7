import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../../utils/api_constants.dart';

class ApiService {
  Future<UserModel> fetchUser(int id) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/users/$id'),
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept': '*/*',
      },
    );
    if (response.statusCode == 200) return UserModel.fromJson(json.decode(response.body));
    throw Exception('Failed to load user');
  }

  Future<UserModel> updateUser(UserModel user) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/users/${user.id}'),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) return UserModel.fromJson(json.decode(response.body));
    throw Exception('Failed to update user');
  }
}

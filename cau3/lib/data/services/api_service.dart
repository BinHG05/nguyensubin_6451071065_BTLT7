import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../../utils/api_constants.dart';

class ApiService {
  Future<Map<String, dynamic>> createPost(PostModel post) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/posts'),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 201) return json.decode(response.body);
    throw Exception('Failed to create post (Status: ${response.statusCode})');
  }
}

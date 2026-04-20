import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../../utils/api_constants.dart';
import '../models/post_model.dart';

class ApiService {
  Future<List<PostModel>> fetchPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await http.get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.postsEndpoint),
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      jsonResponse.shuffle(Random());
      return jsonResponse.take(10).map((p) => PostModel.fromJson(p)).toList();
    }

    throw Exception('Failed to fetch data: ${response.statusCode}');
  }
}

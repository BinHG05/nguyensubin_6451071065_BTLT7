import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/api_constants.dart';
import '../models/task_model.dart';

class ApiService {
  Future<List<TaskModel>> fetchTasks() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/todos?_limit=15'),
    );

    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((task) => TaskModel.fromJson(task)).toList();
    }

    throw Exception('Loi load danh sach (Status: ${response.statusCode})');
  }

  Future<bool> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}/todos/$id'),
    );
    return response.statusCode == 200;
  }
}

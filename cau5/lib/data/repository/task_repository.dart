import '../models/task_model.dart';
import '../services/api_service.dart';

class TaskRepository {
  final ApiService service = ApiService();

  Future<List<TaskModel>> getTasks() {
    return service.fetchTasks();
  }

  Future<bool> deleteTask(int id) {
    return service.deleteTask(id);
  }
}

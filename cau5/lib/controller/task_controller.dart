import '../data/models/task_model.dart';
import '../data/repository/task_repository.dart';

class TaskController {
  final TaskRepository repository = TaskRepository();

  Future<List<TaskModel>> fetchTasks() {
    return repository.getTasks();
  }

  Future<bool> deleteTask(int id) {
    return repository.deleteTask(id);
  }
}

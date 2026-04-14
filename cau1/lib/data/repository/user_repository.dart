import '../models/user_model.dart';
import '../services/api_service.dart';

class UserRepository {
  final ApiService service = ApiService();

  Future<List<User>> getUsers() {
    return service.fetchUsers();
  }
}

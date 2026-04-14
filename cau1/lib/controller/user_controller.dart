import '../data/models/user_model.dart';
import '../data/repository/user_repository.dart';

class UserController {
  final UserRepository repository = UserRepository();

  Future<List<User>> fetchUsers() {
    return repository.getUsers();
  }
}

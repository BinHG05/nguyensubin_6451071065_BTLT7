import '../data/models/user_model.dart';
import '../data/repository/user_repository.dart';

class UserController {
  final UserRepository repository = UserRepository();
  Future<UserModel> getUser(int id) => repository.getUser(id);
  Future<UserModel> updateUser(UserModel user) => repository.updateUser(user);
}

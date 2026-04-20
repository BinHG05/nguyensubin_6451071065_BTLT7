import '../models/user_model.dart';
import '../services/api_service.dart';

class UserRepository {
  final ApiService service = ApiService();
  Future<UserModel> getUser(int id) => service.fetchUser(id);
  Future<UserModel> updateUser(UserModel user) => service.updateUser(user);
}

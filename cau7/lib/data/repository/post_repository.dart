import '../models/post_model.dart';
import '../services/api_service.dart';

class PostRepository {
  final ApiService service = ApiService();
  Future<List<PostModel>> getPosts() => service.fetchPosts();
}

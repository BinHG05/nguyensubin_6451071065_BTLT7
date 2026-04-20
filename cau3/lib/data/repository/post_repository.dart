import '../models/post_model.dart';
import '../services/api_service.dart';

class PostRepository {
  final ApiService service = ApiService();
  Future<Map<String, dynamic>> createPost(PostModel post) => service.createPost(post);
}

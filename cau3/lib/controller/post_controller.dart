import '../data/models/post_model.dart';
import '../data/repository/post_repository.dart';

class PostController {
  final PostRepository repository = PostRepository();
  Future<Map<String, dynamic>> createPost(PostModel post) => repository.createPost(post);
}

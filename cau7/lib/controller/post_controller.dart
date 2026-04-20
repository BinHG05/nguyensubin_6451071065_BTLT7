import '../data/models/post_model.dart';
import '../data/repository/post_repository.dart';

class PostController {
  final PostRepository repository = PostRepository();
  Future<List<PostModel>> fetchPosts() => repository.getPosts();
}

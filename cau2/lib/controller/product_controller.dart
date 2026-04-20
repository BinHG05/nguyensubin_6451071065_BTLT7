import '../data/models/product_model.dart';
import '../data/repository/product_repository.dart';

class ProductController {
  final ProductRepository repository = ProductRepository();

  Future<Product> fetchProduct(int id) {
    return repository.getProductById(id);
  }
}

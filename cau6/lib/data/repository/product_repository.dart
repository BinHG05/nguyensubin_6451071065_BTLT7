import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductRepository {
  final ApiService service = ApiService();

  Future<List<Product>> searchProducts(String keyword) {
    return service.searchProducts(keyword);
  }
}

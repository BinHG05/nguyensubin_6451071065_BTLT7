import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductRepository {
  final ApiService service = ApiService();

  Future<Product> getProductById(int id) {
    return service.fetchProductDetail(id);
  }
}

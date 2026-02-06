import '../core/result.dart';
import '../models/product.dart';
import '../services/api_service.dart';

abstract class ProductRepository {
  Future<Result<Product, String>> getProduct(String barcode);
}

class ProductRepositoryImpl implements ProductRepository {
  final ApiService _apiService;

  ProductRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Result<Product, String>> getProduct(String barcode) async {
    try {
      final product = await _apiService.fetchProduct(barcode);
      return Success(product);
    } on ProductNotFoundException {
      return Failure('Product not found for barcode: $barcode');
    } on ApiException catch (e) {
      return Failure(e.message);
    } catch (e) {
      return Failure('Connection error: $e');
    }
  }
}

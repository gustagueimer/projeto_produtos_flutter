import 'package:product_app/features/product/domain/entities/product.dart'; 

abstract class ProductRepository {
  void saveCache(List<Product> products); 
  Future<List<Product>> getProducts(); 
  Future<Product> getProductById(int id); 
  Future<dynamic> saveProduct(Product product);
  Future<dynamic> updateProduct(Product product);
  Future<dynamic> deleteProduct(int id);
}
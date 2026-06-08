import 'package:product_app/core/errors/faliure.dart';
import 'package:product_app/features/product/domain/entities/product.dart';
import 'package:product_app/features/product/domain/repositories/product_repository.dart';
import 'package:product_app/features/product/data/models/product_model.dart';
import 'package:product_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:product_app/features/product/data/datasources/product_cache_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remote = ProductRemoteDatasource();
  final ProductCacheDatasource cache = ProductCacheDatasource();
    
  ProductRepositoryImpl();
    
  @override
  Future<List<Product>> getProducts() async {
    try{
      final cached = cache.get();
      if(cached != null) {
        return cached
        .map((m) => Product(
          id: m.id, 
          title: m.title, 
          description: m.description,
          price: m.price, 
          image: m.image,
          fav: m.fav,
          ))
          .toList();
      }
      final models = await remote.getProducts();
      return models
      .map((m) => Product(
        id: m.id,
        title: m.title,
        description: m.description,
        price: m.price,
        image: m.image,
        fav: m.fav,
      ))
      .toList();
    } catch (e) {
      throw Failure("Não foi possível carregar os produtos");
    }
  }

  @override
  void saveCache(List<Product> products) {
    cache.save(products
     .map((p) => ProductModel(
        id: p.id, 
        title: p.title, 
        description: p.description,
        price: p.price, 
        image: p.image,
        fav: p.fav
      ))
      .toList()
    );
  }

  @override
  Future<Product> getProductById(int id) async {
    try {
      final p = await remote.getProductById(id);
      return Product(
        id: p.id,
        title: p.title,
        description: p.description,
        price: p.price,
        image: p.image,
        fav: false
      );
    } catch(e) {
      throw Failure("Não foi possível buscar o produto");
    }
  }

  @override
  Future<bool> saveProduct(Product product) async {
    try{
      final response = await remote.saveProduct(
        ProductModel(
        id: product.id,
        title: product.title,
        description: product.description,
        price: product.price,
        image: product.image,
        )
      );
      
      if(response != true) {
        throw Exception();
      }

      return response;
    } catch(e) {
      throw Failure("Não foi possível salvar o produto");
    }  
  } 

  @override
  Future updateProduct(Product product) async {
    try{
      final response = await remote.saveProduct(
        ProductModel(
        id: product.id,
        title: product.title,
        description: product.description,
        price: product.price,
        image: product.image,
        )
      );
      
      if(response != true) {
        throw Exception();
      }

      return response;
    } catch(e) {
      throw Failure("Não foi possível atualizar o produto");
    }
  }

  @override
  Future<bool> deleteProduct(int id) async {
    try {
      final response = await remote.deleteProduct(id);
      
      if(response != true) {
        throw Exception();
      }

      return response;
    } catch(e) {
      throw Failure("Não foi possível apagar o produto");
    }
  }
}
import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:product_app/core/errors/faliure.dart';
import 'package:product_app/core/utils/stringbuffer.dart';
import 'package:product_app/features/product/data/models/product_model.dart';

Logger logger = Logger();

class ProductRemoteDatasource {
  final Client client = Client();
  final String link = "https://fakestoreapi.com/products";

  ProductRemoteDatasource();
  
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(
      Uri.parse(link)
    );
    logger.d(response.statusCode);

    List<dynamic> data = jsonDecode(response.body);

    List<ProductModel> products = [];
    
    for(var item in data) {
      products.add(ProductModel.fromJson(item));
    }

    return products;
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await client.get(
      Uri.parse(Stringbuffer.writeSumthing(Stringbuffer.writeSumthing(link, "/"), id.toString()))
    );
    logger.d(response.statusCode);

    dynamic data = jsonDecode(response.body);
    logger.d(data);
    
    return ProductModel.fromJson(data);
  }

  Future<bool> saveProduct(ProductModel product) async {
    Map<String, String> headers = {
      "Content-Type":"application/json"
    };
    logger.d(product.toJson());
    logger.d(jsonEncode(product.toJson()));
    final response = await client.post(
      Uri.parse(link),
      headers: headers,
      body: jsonEncode(product.toJson()),
    );
    logger.d(response.statusCode);

    if(response.statusCode != 201) {
      throw Failure("algo deu errado :P");
    }

    return true; 
  } 

  Future<bool> updateProduct(ProductModel product) async {
    Map<String, String> headers = {
      "Content-Type":"application/json"
    };

    final response = await client.put(
      Uri.parse(Stringbuffer.writeSumthing(Stringbuffer.writeSumthing(link, "/"), product.id.toString())),
      headers: headers,
      body: jsonEncode(product.toJson()),
    );
    logger.d(response.statusCode);

    if(response.statusCode != 200) {
      throw Failure("algo deu errado :P");
    }

    return true; 
  }

  Future<bool> deleteProduct(int id) async {
    final response = await client.delete(
      Uri.parse(Stringbuffer.writeSumthing(Stringbuffer.writeSumthing(link, "/"), id.toString()))
    );
    logger.d(response.statusCode);

    if(response.statusCode != 200) {
      throw Failure("algo deu errado :P");
    }

    return true; 
  }
}
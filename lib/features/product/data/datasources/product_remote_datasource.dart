import 'dart:convert';
import 'package:http/http.dart';
import '../models/product_model.dart';

class ProductRemoteDatasource {
  final Client client;
  final Uri link = Uri.parse("https://fakestoreapi.com/products");

  ProductRemoteDatasource(this.client);
  
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(
      link
    );
    
    List<dynamic> data = jsonDecode(response.body);
    
    List<ProductModel> products = [];
    data.forEach((item) {
      products.add(ProductModel.fromJson(item));
    });

    return products;
  }
}
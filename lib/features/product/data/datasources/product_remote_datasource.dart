import 'dart:convert';
import 'package:http/http.dart';
import 'package:product_app/features/product/data/models/product_model.dart';

class ProductRemoteDatasource {
  final Client client = Client();
  final Uri link = Uri.parse("https://fakestoreapi.com/products");

  ProductRemoteDatasource();
  
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(
      link
    );
    
    List<dynamic> data = jsonDecode(response.body);
    
    List<ProductModel> products = [];
    
    for(var item in data) {
      products.add(ProductModel.fromJson(item));
    }

    return products;
  }
}
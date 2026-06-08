import 'package:product_app/features/product/domain/entities/product.dart';

class ProductDetailsState {
  final Product? produto;
  final bool isLoading;
  final String? error;

  const ProductDetailsState({
    this.produto, 
    this.isLoading = false, 
    this.error
  });

  ProductDetailsState copyWith({
    Product? produto,
    bool? isLoading,
    String? error
  }) {
    return ProductDetailsState(
      produto: produto ?? this.produto,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error
    );
  }
}
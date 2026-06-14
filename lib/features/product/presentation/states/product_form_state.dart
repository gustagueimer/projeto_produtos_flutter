import 'package:product_app/features/product/domain/entities/product.dart';

class ProductFormState {
  final Product? produto;
  final bool formEditar;
  final bool isLoading;
  final String? error;

  ProductFormState({
    this.produto,
    this.formEditar = false,
    this.isLoading = false,
    this.error,
  });

  ProductFormState copyWith({
    final Product? produto,
    final bool? formEditar,
    final bool? isLoading,
    final String? error,
  }) {
    return ProductFormState(
      produto: produto ?? this.produto,
      formEditar: formEditar ?? this.formEditar,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:product_app/features/product/domain/entities/product.dart';
import 'package:product_app/features/product/presentation/states/product_details_state.dart';

Logger logger = Logger();

class ProductDetailsStateNotifier extends Notifier<ProductDetailsState> {

  @override
  ProductDetailsState build() {
    return ProductDetailsState();
  }

  void changeProduto(Product? produto) {
    state = state.copyWith(produto: produto);
  }

  void changeLoading() {
    if(state.isLoading) {
      state = state.copyWith(isLoading: false);
      return;
    }
    state = state.copyWith(isLoading: true);
  }

  void changeError(String error) {
    state = state.copyWith(error: error);
  }

  void changeFav(Product p, bool? favState) {
    Product produtoAtualizado = p.copyWith(fav: favState);
    logger.d(produtoAtualizado);
    state = state.copyWith(produto: produtoAtualizado);
  }
}

final productDetailsStateNotifierProvider = NotifierProvider<ProductDetailsStateNotifier, ProductDetailsState>(() {
  return ProductDetailsStateNotifier();
});
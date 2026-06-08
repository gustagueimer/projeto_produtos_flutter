import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/features/product/domain/entities/product.dart';
import 'package:product_app/features/product/presentation/states/product_details_state.dart';

class ProductDetailsStateNotifier extends Notifier<ProductDetailsState> {

  @override
  ProductDetailsState build() {
    return ProductDetailsState();
  }

  void changeProduto(Product produto) {
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
}

final productDetailsStateNotifierProvider = NotifierProvider<ProductDetailsStateNotifier, ProductDetailsState>(() {
  return ProductDetailsStateNotifier();
});
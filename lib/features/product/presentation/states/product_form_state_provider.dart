import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/features/product/domain/entities/product.dart';
import 'package:product_app/features/product/presentation/states/product_form_state.dart';

class ProductFormStateNotifier extends Notifier<ProductFormState> {

  @override
  ProductFormState build() {
    return ProductFormState();
  }

  void updateProduto(Product? produto) {
    state = state.copyWith(produto: produto);
  }

  void clearProduto() {
    state = state.copyWith(produto: null);
  }

  void changeFormMode() {
    if(!state.formEditar) {
      state = state.copyWith(formEditar: true);
      return;
    }
    state = state.copyWith(formEditar: false);
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

final productFormStateNotifierProvider = NotifierProvider<ProductFormStateNotifier, ProductFormState>(() {
  return ProductFormStateNotifier();
});
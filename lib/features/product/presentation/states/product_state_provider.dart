import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:product_app/features/product/domain/entities/product.dart';
import 'package:product_app/features/product/presentation/states/product_state.dart';

Logger logger = Logger();

class ProductStateNotifier extends Notifier<ProductState> {

  @override
  ProductState build() {
    return ProductState();
  }

  void changeLoading() {
    if(state.isLoading) {
      state = state.copyWith(isLoading: false);
      return;
    }
    state = state.copyWith(isLoading: true);
  }

  void changeProductList(List<Product> products) {
    state = state.copyWith(products: products);
  }

  void changeError(String error) {
    state = state.copyWith(error: error);
  }

  void changeFav(Product p, bool? favState) {
    if (!state.products.contains(p)) {
      return;
    }
    List<Product> updatedList = state.products;
    int idx = updatedList.lastIndexWhere((product) => product.id == p.id);
    Product updatedProduct = updatedList.elementAt(idx).copyWith(fav: favState);
    updatedList[idx] = updatedProduct; 
    logger.d(updatedList.elementAt(idx).toString());
    state = state.copyWith(products: updatedList);
  }
}

final productStateNotifierProvider = NotifierProvider<ProductStateNotifier, ProductState>(() {
    return ProductStateNotifier();
  }
);
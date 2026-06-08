import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:product_app/features/product/domain/entities/product.dart';
import 'package:product_app/features/product/domain/repositories/product_repository.dart';
import 'package:product_app/features/product/presentation/pages/product_details_page.dart';
import 'package:product_app/features/product/presentation/states/product_details_state_provider.dart';
import 'package:product_app/features/product/presentation/states/product_state_provider.dart';
import 'package:product_app/features/product/presentation/viewmodels/product_details_viewmodel.dart';

class ProductViewModel {
  final ProductRepository repository = ProductRepositoryImpl();
  final WidgetRef ref;

  ProductViewModel(this.ref);

  Future<void> loadProducts() async {
    ref.watch(productStateNotifierProvider.notifier).changeLoading();
    try {
      final products = await repository.getProducts();
      repository.saveCache(products);
      ref.watch(productStateNotifierProvider.notifier).changeProductList(products);
      ref.watch(productStateNotifierProvider.notifier).changeLoading();
    } catch (e) {
      ref.watch(productStateNotifierProvider.notifier).changeError(e.toString());
      ref.watch(productStateNotifierProvider.notifier).changeLoading();
    }
  }

  void changefav(Product p) {
    if(!p.fav) {
    ref.watch(productStateNotifierProvider.notifier).changeFav(p, true);
    return;
    }
    ref.watch(productStateNotifierProvider.notifier).changeFav(p, false);
  }

  MaterialColor fave(Product p) {
    if(p.fav) {
      return Colors.amber;
    }
    return Colors.grey;
  }

  void navigateToDetails(BuildContext context, Product produto) {
    ref.read(productDetailsStateNotifierProvider.notifier).changeProduto(produto);
    Navigator.push(
      context, 
      MaterialPageRoute<void>(
        builder: (context) => ProductDetailsPage(viewmodel: ProductDetailsViewmodel(ref: ref))
      )
    );
  }
}
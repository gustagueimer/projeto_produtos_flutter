import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/features/product/domain/entities/product.dart';
import 'package:product_app/features/product/presentation/states/product_details_state_provider.dart';

class ProductDetailsViewmodel {
  final WidgetRef ref;

  ProductDetailsViewmodel({required this.ref});

  void changeLoading() {
    if(ref.read(productDetailsStateNotifierProvider).isLoading) {}
  }

  void changeProduto(Product produto) {
    ref.read(productDetailsStateNotifierProvider.notifier).changeProduto(produto);
  }

}
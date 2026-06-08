import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/features/product/domain/entities/product.dart';
import 'package:product_app/features/product/presentation/states/product_details_state_provider.dart';
import 'package:product_app/features/product/presentation/states/product_state_provider.dart';

class ProductDetailsViewmodel {
  final WidgetRef ref;

  ProductDetailsViewmodel({required this.ref});

  void changeLoading() {
    if(ref.read(productDetailsStateNotifierProvider).isLoading) {}
  }

  void changeProduto(Product produto) {
    ref.read(productDetailsStateNotifierProvider.notifier).changeProduto(produto);
  }

  void changefav(Product p) {
    if(!p.fav) {
    ref.read(productDetailsStateNotifierProvider.notifier).changeFav(p, true);
    ref.read(productStateNotifierProvider.notifier).changeFav(p, true);
    return;
    }
    ref.read(productDetailsStateNotifierProvider.notifier).changeFav(p, false);
    ref.read(productStateNotifierProvider.notifier).changeFav(p, false);
  }

  MaterialColor fave(Product p) {
    if(p.fav) {
      return Colors.amber;
    }
    return Colors.grey;
  }

}
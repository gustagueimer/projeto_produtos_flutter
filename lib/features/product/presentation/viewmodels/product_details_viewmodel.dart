import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:product_app/core/errors/faliure.dart';
import 'package:product_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:product_app/features/product/domain/entities/product.dart';
import 'package:product_app/features/product/domain/repositories/product_repository.dart';
import 'package:product_app/features/product/presentation/states/product_details_state_provider.dart';
import 'package:product_app/features/product/presentation/states/product_state_provider.dart';
import 'package:product_app/features/product/presentation/states/product_form_state_provider.dart';
import 'package:product_app/features/product/presentation/pages/product_form_page.dart';
import 'package:product_app/features/product/presentation/viewmodels/product_form_viewmodel.dart';

Logger logger = Logger();

class ProductDetailsViewmodel {
  final WidgetRef ref;
  final ProductRepository repository = ProductRepositoryImpl();

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

  dynamic returnImage(Product p) {
    if(p.image.isNotEmpty) {
      return Image.network(
        p.image,
        width: 250.0,
        height: 250.0,
      );
    }
    if(p.fotoBytes != null){
      return Image.memory(
        p.fotoBytes!,
        width: 250.0,
        height: 250.0,
      );
    }
    return Icon(
      Icons.no_photography,
      color: Colors.grey,
      size: 250.0,
    );
  }

  void deleteProduct(BuildContext context) async {
    ref.read(productDetailsStateNotifierProvider.notifier).changeLoading();
    try {
      Product p = ref.read(productDetailsStateNotifierProvider).produto!;
      List<Product> list = ref.read(productStateNotifierProvider).products.toList();
      bool response = false;
      if(p.id > 20) {
        list.remove(p);
        response = true;
      } else {
        response = await repository.deleteProduct(p.id);
        list.remove(p);
      }
      if(!response) {
        throw Failure("Erro ao apagar o produto");
      }
      repository.saveCache(list);
      ref.read(productStateNotifierProvider.notifier).changeProductList(list);
      ref.read(productDetailsStateNotifierProvider.notifier).changeLoading();
    } catch(e, stack) {
      logger.d(e, stackTrace: stack);
      ref.read(productDetailsStateNotifierProvider.notifier).changeError(e.toString());
      ref.read(productDetailsStateNotifierProvider.notifier).changeLoading();
    }
  }

  void navigateBackToProducts(BuildContext context) {
    ref.read(productDetailsStateNotifierProvider.notifier).changeProduto(null);
    Navigator.pop(context);
  }

  void navigateToEditProduct(BuildContext context, Product produto) {
    ref.read(productFormStateNotifierProvider.notifier).updateProduto(produto);
    if(!ref.read(productFormStateNotifierProvider).formEditar) {
      ref.read(productFormStateNotifierProvider.notifier).changeFormMode();
    }
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ProductFormPage(viewmodel: ProductFormViewmodel(ref: ref))
      )
    );
  }
}
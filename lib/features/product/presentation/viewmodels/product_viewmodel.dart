import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:product_app/core/presentation/states/login_page_state_provider.dart';
import 'package:product_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:product_app/features/product/domain/entities/product.dart';
import 'package:product_app/features/product/domain/repositories/product_repository.dart';
import 'package:product_app/features/product/presentation/pages/product_details_page.dart';
import 'package:product_app/features/product/presentation/pages/product_form_page.dart';
import 'package:product_app/features/product/presentation/states/product_details_state_provider.dart';
import 'package:product_app/features/product/presentation/states/product_form_state_provider.dart';
import 'package:product_app/features/product/presentation/states/product_state_provider.dart';
import 'package:product_app/features/product/presentation/viewmodels/product_details_viewmodel.dart';
import 'package:product_app/features/product/presentation/viewmodels/product_form_viewmodel.dart';
import 'package:product_app/features/user/data/repositories/user_repository_impl.dart';

Logger logger = Logger();

class ProductViewModel {
  final ProductRepository repository = ProductRepositoryImpl();
  final UserRepositoryImpl userRepository = UserRepositoryImpl();
  final WidgetRef ref;

  ProductViewModel(this.ref);

  void encerrarSessao() async {
    try {
      await userRepository.deleteTokenCache();
      await userRepository.deleteUserCache();
      ref.read(loginPageStateNotifierProvider.notifier).changeUser(null);
      ref.invalidate(productStateNotifierProvider);
    } catch(e, stack) {
      logger.e(e, stackTrace: stack);
    }
  }

  Future<void> loadProducts() async {
    ref.watch(productStateNotifierProvider.notifier).changeLoading();
    try {
      final products = await repository.getProducts();
      atualizarListaDeProdutos(products);
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

  dynamic returnImage(Product p) {
    if(p.image.isNotEmpty) {
      return Image.network(
        p.image,
        width: 25.0,
        height: 25.0,
      );
    } else if(p.fotoBytes != null) {
      return Image.memory(
        p.fotoBytes!,
        width: 25.0,
        height: 25.0,
      );
    }
    return Icon(
      Icons.image_not_supported,
      color: Colors.grey,
      size: 25.0,
    );
  }

  void atualizarListaDeProdutos(List<Product> listaNova) {
    try {
    List<Product> listaAntiga = ref.read(productStateNotifierProvider).products.toList();
    if(listaAntiga.isEmpty) {
      ref.read(productStateNotifierProvider.notifier).changeProductList(listaNova);
      repository.saveCache(listaNova);
      return;
    }
    List<Product> listaUltimate = listaNova.toList();
    bool wtf = true;
    for(Product produto in listaAntiga) {

      // encontra indíce de produto com id igual na lista antiga
      int idxListaAntiga = listaNova.indexWhere((item) {
        return item.id == produto.id ? true : false;
      });
      if(!(idxListaAntiga == -1)) {
        listaUltimate.insert(idxListaAntiga, listaNova.elementAt(idxListaAntiga));
        listaUltimate.removeAt(idxListaAntiga+1);
        // se for a primeira vez, ele vai por no fim com base no tamanho da lista antiga (por que a nova é uma cópia), da segunda vez em diante ele vai por no fim com base no tamanho da lista nova;
        if(wtf) {
          wtf = false;
          listaUltimate.insert(listaNova.length, produto.copyWith(id: listaNova.last.id+1));
        } else {
          listaUltimate.insert(listaUltimate.length, produto.copyWith(id: listaUltimate.last.id+1));
        }
        logger.d([
          "produto com o mesmo id",
          produto,
          "indice na lista antiga",
          idxListaAntiga,
          "lista após o processo",
          listaUltimate
        ]);
        continue;
      }
      if(listaUltimate.contains(produto)) {
        logger.d([
          "lmao skip",
          produto,
          listaUltimate.contains(produto),
        ]);
        continue;
      }

      // encontra indíce de produto com id igual na lista nova
      int idxListaNova = listaUltimate.indexWhere((item) {
        if(item.id == produto.id) {
           return true;
        } 
        return false;
      });
      if(!(idxListaNova == -1)) {
        listaUltimate.insert(listaUltimate.length ,produto.copyWith(id: listaUltimate.last.id+1));
        logger.d([
          "indice na lista nova",
          idxListaNova,
          "lista após o processo",
          listaUltimate,
        ]);
        continue;
      }
      listaUltimate.add(produto);
    }
    logger.d(listaUltimate);
    repository.saveCache(listaUltimate);
    ref.read(productStateNotifierProvider.notifier).changeProductList(listaUltimate);
    } catch(e, stack) {
      logger.e(e, stackTrace: stack);
    }
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

  void navigateToNewProduct(BuildContext context) {
    try{
      if(ref.read(productFormStateNotifierProvider).produto == null) {
        ref.read(productFormStateNotifierProvider.notifier).updateProduto(
          Product(
            id: 0,
            title: "",
            description: "",
            price: 0.0,
            image: "", 
          )
        );
      }
      if(ref.read(productFormStateNotifierProvider).formEditar) {
        ref.read(productFormStateNotifierProvider.notifier).changeFormMode();
      }
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => ProductFormPage(viewmodel: ProductFormViewmodel(ref: ref))
        )
      );
    } catch(e, stack) {
      logger.e(e, stackTrace: stack);
    }
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:product_app/core/errors/faliure.dart';
import 'package:product_app/features/product/domain/entities/product.dart';
import 'package:product_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:product_app/features/product/presentation/states/product_details_state_provider.dart';
import 'package:product_app/features/product/presentation/states/product_form_state_provider.dart';
import 'package:product_app/features/product/presentation/states/product_state_provider.dart';

Logger logger = Logger();

class ProductFormViewmodel {
  final WidgetRef ref;
  final ProductRepositoryImpl repository = ProductRepositoryImpl();
  final provider = productFormStateNotifierProvider;
  TextEditingController idProduto = TextEditingController();
  TextEditingController tituloProduto = TextEditingController();
  TextEditingController descricaoProduto = TextEditingController();
  TextEditingController precoProduto = TextEditingController();
  TextEditingController categoriaProduto = TextEditingController();

  ProductFormViewmodel({required this.ref});

  void syncControllers() {
    idProduto = TextEditingController.fromValue(TextEditingValue(text: ref.read(provider).produto!.id.toString()));
    tituloProduto = TextEditingController.fromValue(TextEditingValue(text: ref.read(provider).produto!.title));
    descricaoProduto = TextEditingController.fromValue(TextEditingValue(text: ref.read(provider).produto!.description));
    precoProduto = TextEditingController.fromValue(TextEditingValue(text: ref.read(provider).produto!.price.toString()));
    //categoriaProduto = TextEditingController.fromValue(TextEditingValue(text: ref.read(provider).produto!.category));
  }

  void updateControllers() {
    Product p = ref.read(provider).produto!.copyWith();
    logger.d(<dynamic>["antes", p]);
    if(idProduto.value.text != p.id.toString()) {
      p = p.copyWith(id: double.parse(idProduto.value.text.replaceAll(',', '.')).toInt());
    }
    if(tituloProduto.value.text != p.title) {
      p = p.copyWith(title: tituloProduto.value.text);
    }
    if(descricaoProduto.value.text != p.description) {
      p = p.copyWith(description: descricaoProduto.value.text);
    }
    if(precoProduto.value.text != p.price.toString()) {
      p = p.copyWith(price: double.parse(precoProduto.value.text.replaceAll(',', '.')));
    }
    logger.d(<dynamic>["depois", p]);
    ref.read(provider.notifier).updateProduto(p);
  }

  void reciclarProduto() {
    ref.read(provider.notifier).updateProduto(
      Product(
        id: 0, 
        title: "", 
        description: "", 
        price: 0.0, 
        image: ""
      )
    );
  }

  void formatarValorMonetario() {
    String numeric = precoProduto.value.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeric.isEmpty) {
      precoProduto.value = TextEditingValue(
        text: "",
        selection: TextSelection.collapsed(
          offset: "".length,
        ),
      ); 
    }
    while (numeric.length < 3) {
      numeric = '0$numeric';
    }
    double valor = double.parse(numeric) / 100.0;
    String valorFormatado = valor.toStringAsFixed(2).replaceAll('.', ',');
    if (valorFormatado != precoProduto.value.text) {
      precoProduto.value = TextEditingValue(
        text: valorFormatado,
        selection: TextSelection.collapsed(
          offset: valorFormatado.length,
        ),
      );
    }
  }

  Image returnImage(Product p) {
    if(p.fotoBytes == null) {
      return Image.network(
        p.image, 
        height: 200, 
        width: double.infinity, 
        fit: BoxFit.cover
      );
    }
    return Image.memory(
      p.fotoBytes!, 
      height: 200, 
      width: double.infinity, 
      fit: BoxFit.cover
    );
  }

  Future<void> selecionarImagem(BuildContext context) async {
    updateControllers();
    try {
      XFile? image;
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
      final bytes = await image!.readAsBytes();
      ref.read(productFormStateNotifierProvider.notifier).updateProduto(ref.read(productFormStateNotifierProvider).produto!.copyWith(fotoBytes: bytes));
      logger.d('Foto salva: ${bytes.length} bytes');
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);
    }
  }

  void atualizarListaDeProdutos(Product produto) {
    List<Product> listaNova = ref.read(productStateNotifierProvider).products.toList();
    int idx = listaNova.indexWhere((item) {
      if(item.id == produto.id) {
        return true;
      }
      return false;
    });
    // fluxo caso seja a adição de um item novo 
    if(idx == -1) {
      listaNova.add(produto);
      ref.read(productStateNotifierProvider.notifier).changeProductList(listaNova);
      repository.saveCache(listaNova);
      reciclarProduto();
      ref.read(provider.notifier).changeLoading();
      return;
    }
    // fluxo caso seja a edição de um item existente
    listaNova.insert(idx, produto);
    listaNova.removeAt(idx+1);
    ref.read(productStateNotifierProvider.notifier).changeProductList(listaNova);
    ref.read(productDetailsStateNotifierProvider.notifier).changeProduto(produto);
    repository.saveCache(listaNova);
    reciclarProduto();
    ref.read(provider.notifier).changeLoading();
  }

  Future<void> criarProduto(BuildContext context) async {
    updateControllers();
    ref.read(provider.notifier).changeLoading();
    try{
      Product? produto = ref.read(provider).produto;
      if(produto == null) {
        throw Failure("Erro: produto nulo");
      }
      final salvar = await repository.saveProduct(ref.read(provider).produto!);
      if(salvar) {
        atualizarListaDeProdutos(produto);
      }
    } catch(e, stack) {
      logger.e(e, stackTrace: stack);
      ref.read(provider.notifier).changeError(e.toString());
      ref.read(provider.notifier).changeLoading();
    }
  }

  Future<void> atualziarProduto(BuildContext context) async {
    updateControllers();
    ref.read(provider.notifier).changeLoading();
    try {
      Product? produto = ref.read(provider).produto;
      if(produto == null) {
        throw Failure("Erro: produto nulo");
      }
      final salvar = await repository.updateProduct(produto);
      if(salvar) {
        atualizarListaDeProdutos(produto);
      }
    } catch(e, stack) {
      logger.e(e, stackTrace: stack);
      ref.read(provider.notifier).changeError(e.toString());
      ref.read(provider.notifier).changeLoading();
    }
  }
}
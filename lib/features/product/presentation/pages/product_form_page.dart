import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:product_app/features/product/presentation/states/product_form_state_provider.dart';
import 'package:product_app/features/product/presentation/viewmodels/product_form_viewmodel.dart';
import 'package:product_app/features/product/presentation/widgets/custom_input_field.dart';

Logger logger = Logger();

class ProductFormPage extends ConsumerWidget{
  final ProductFormViewmodel viewmodel;

  const ProductFormPage({super.key, required this.viewmodel});

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    final plep = ref.watch(productFormStateNotifierProvider);
    viewmodel.syncControllers();
    /*
    logger.d(plep.formEditar);
    logger.d(plep.produto);
    logger.d(viewmodel.idProduto);
    logger.d(viewmodel.idProduto.value);
    logger.d(viewmodel.tituloProduto.value);
    logger.d(viewmodel.descricaoProduto.value);
    logger.d(viewmodel.precoProduto.value);
    */
    if(plep.formEditar) {
      return Scaffold(
        appBar: AppBar(title: Text("Editar Produto")),
        body: Builder(
          builder: (context) {
            if(plep.isLoading) {
              return const Center(child:CircularProgressIndicator());
            }
            if(plep.error != null) {
              return Center(child: Text(plep.error!));
            }
            return ListView.builder(
              itemCount: 1,
              padding: EdgeInsetsGeometry.all(20.0),
              itemBuilder:(context, index) {
                return Column(
                  spacing: 16.0,
                  children: <Widget>[
                    CustomInputField.createField(
                      controller: viewmodel.idProduto,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      readOnly: true,
                      onEditingComplete: () {viewmodel.updateControllers();},
                    ),
                    CustomInputField.createField(
                      controller: viewmodel.tituloProduto,
                      onEditingComplete: () {viewmodel.updateControllers();},
                    ),
                    CustomInputField.createField(
                      controller: viewmodel.descricaoProduto,
                      onEditingComplete: () {viewmodel.updateControllers();},
                    ),
                    CustomInputField.createField(
                      controller: viewmodel.precoProduto,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onEditingComplete: () {viewmodel.updateControllers();},
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.photo, color: Colors.white),
                        label: const Text("Selecionar Foto", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
                      onPressed: () => viewmodel.selecionarImagem(context),
                      ),
                    ),
                    if (plep.produto!.fotoBytes != null) ...[
                      const SizedBox(height: 2),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: viewmodel.returnImage(plep.produto!),
                      ),
                    ],
                    ElevatedButton.icon(
                      onPressed: () {
                        viewmodel.atualziarProduto(context);
                      },
                      label: Text("Salvar Produto"),
                      icon: Icon(Icons.save),
                    ),
                  ],
                );
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Criar Produto")),
      body: Builder(
        builder: (context) {
          if(plep.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if(plep.error != null) {
            return Center(child: Text(plep.error!));
          }
          return ListView.builder(
            itemCount: 1,
            padding: EdgeInsetsGeometry.all(20.0),
            itemBuilder:(context, index) {
              return Column(
                spacing: 26.0,
                children: <Widget>[
                  CustomInputField.createField(
                    labelText: "ID do Produto",
                    controller: viewmodel.idProduto,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onEditingComplete: () {viewmodel.updateControllers();},
                  ),
                  CustomInputField.createField(
                    labelText: "Nome do Produto",
                    controller: viewmodel.tituloProduto,
                    onEditingComplete: () {viewmodel.updateControllers();},
                  ),
                  CustomInputField.createField(
                    labelText: "Descrição do produto",
                    controller: viewmodel.descricaoProduto,
                    onEditingComplete: () {viewmodel.updateControllers();},
                  ),
                  CustomInputField.createField(
                    labelText: "Preço do Produto",
                    controller: viewmodel.precoProduto,
                    keyboardType: TextInputType.number,
                    onChanged: (valor) {viewmodel.formatarValorMonetario();},
                    onEditingComplete: () {viewmodel.updateControllers();},
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.photo, color: Colors.white),
                      label: const Text("Selecionar Foto", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
                    onPressed: () => viewmodel.selecionarImagem(context),
                    ),
                  ),
                  if (plep.produto!.fotoBytes != null) ...[
                    const SizedBox(height: 2),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: viewmodel.returnImage(plep.produto!),
                    ),
                  ],
                  ElevatedButton.icon(
                    onPressed: () {
                      viewmodel.criarProduto(context);
                    },
                    label: Text("Salvar Produto"),
                    icon: Icon(Icons.save),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
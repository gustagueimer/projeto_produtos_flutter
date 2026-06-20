import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/core/presentation/states/login_page_state_provider.dart';
import 'package:product_app/features/product/presentation/states/product_state_provider.dart';
import 'package:product_app/features/product/presentation/viewmodels/product_viewmodel.dart';

class ProductPage extends ConsumerWidget {
  final ProductViewModel viewModel;
  const ProductPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plop = ref.watch(productStateNotifierProvider);
    final plep = ref.read(loginPageStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        automaticallyImplyLeading: false,
        actions: [
          Row(
            spacing: 8.0,
            children: [
              CircleAvatar(
                radius: 20.0,
                child: Image.network(plep.sessao?.image ?? "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-4.png"),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                child:Text("${plep.sessao?.firstName} ${plep.sessao?.lastName}")
              ),
            ],
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          if(plep.sessao == null) {
            Navigator.maybePop(context);
          }
          if(plop.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }
          if(plop.error != null) {
            return Center(child: Text(plop.error!));
          }
          return ListView.builder(
            itemCount: plop.products.length,
            itemBuilder: (context, index) {
              final product = plop.products[index];
              return ListTile(
                onTap: () {
                  viewModel.navigateToDetails(context, product);
                },
                leading: viewModel.returnImage(product),
                title: Text(product.title),
                subtitle: Text("\$${product.price}"),
                trailing: IconButton(
                  onPressed: () => {
                    viewModel.changefav(product)
                  },
                  color: viewModel.fave(product),
                  highlightColor: Colors.yellow,
                  icon: Icon(
                    Icons.star,
                  )            
                ),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.loadProducts,
        child: const Icon(Icons.download),
      ),
      persistentFooterButtons: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12.0,
            children: [
              ElevatedButton(
                onPressed: () {
                  viewModel.encerrarSessao();
                }, 
                child: Text("Encerrar Sessão")
              ),
              ElevatedButton(
                onPressed: () {
                  viewModel.navigateToNewProduct(context);
                }, 
                child: Text("Criar Produto")
              ),
            ],
          ),
        ),
      ],
    );
  }
}
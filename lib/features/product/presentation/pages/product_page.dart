import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/features/product/presentation/states/product_state_provider.dart';
import 'package:product_app/features/product/presentation/viewmodels/product_viewmodel.dart';

class ProductPage extends ConsumerWidget {
  final ProductViewModel viewModel;
  const ProductPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plop = ref.watch(productStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: Builder(
        builder: (context) {
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
        Center(child: 
          ElevatedButton(
            onPressed: () {
              viewModel.navigateToNewProduct(context);
            }, 
            child: Text("Criar Produto")
          ),
        ),
      ],
    );
  }
}
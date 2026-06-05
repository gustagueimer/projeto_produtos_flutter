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
                leading: Image.network(product.image),
                title: Text(product.title),
                subtitle: Text("\$${product.price}"),
                trailing: IconButton(onPressed: () => {viewModel.changefav(product)},
                 icon: Icon(
                  Icons.star,
                  color: viewModel.fave(product),
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
    );
  }
}
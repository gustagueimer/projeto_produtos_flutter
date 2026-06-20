import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/core/utils/stringbuffer.dart';
import 'package:product_app/features/product/domain/entities/product.dart';
import 'package:product_app/features/product/presentation/states/product_details_state_provider.dart';
import 'package:product_app/features/product/presentation/viewmodels/product_details_viewmodel.dart';

class ProductDetailsPage extends ConsumerWidget{
  final ProductDetailsViewmodel viewmodel;
  const ProductDetailsPage({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plup = ref.watch(productDetailsStateNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              viewmodel.navigateBackToProducts(context);
            });
          }, 
          icon: Icon(Icons.arrow_back)),
        title: Text("Produto")
        ),
      body: Builder(
        builder: (context) {
          if(plup.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }
          if(plup.error != null) {
            return Center(child: Text(plup.error!));
          }
          return ListView.builder(
            itemCount: 1,
            padding: EdgeInsetsGeometry.all(20.0),
            itemBuilder: (context, index) {
              return Column(
                textBaseline: TextBaseline.alphabetic,
                spacing: 10.0,
                children: <Widget>[
                  viewmodel.returnImage(plup.produto ?? Product(id: 0, title: "title", description: "description", price: 0.0, image: "")),
                  Text(
                    plup.produto?.title ?? "title",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () => {
                            viewmodel.deleteProduct(context),
                            viewmodel.navigateBackToProducts(context),
                          },
                          color: Colors.redAccent,
                          icon: Icon(
                            Icons.delete,
                          )
                        ),
                        IconButton(
                          onPressed: () => {
                            viewmodel.navigateToEditProduct(context, plup.produto ?? Product(id: 0, title: "title", description: "description", price: 0.0, image: ""))
                          },
                          color: Colors.greenAccent,
                          icon: Icon(
                            Icons.edit,
                          )
                        ),
                        IconButton(
                          onPressed: () => {
                            if(plup.produto != null) 
                            viewmodel.changefav(plup.produto ?? Product(id: 0, title: "title", description: "description", price: 0.0, image: ""))
                          },
                          color: viewmodel.fave(plup.produto ?? Product(id: 0, title: "title", description: "description", price: 0.0, image: "")),
                          highlightColor: Colors.yellow,
                          icon: Icon(
                            Icons.star,
                          )
                        ),
                      ],
                    ) 
                  ),
                  
                  Text(
                    Stringbuffer.writeSumthing("R\$ ", plup.produto?.price.toString() ?? "0.00"),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  Text("Descrição do produto:"),
                  Text(plup.produto?.description ?? "desc"),
                ],
              );
            }
          );
        }
      ),
    );
  }
}
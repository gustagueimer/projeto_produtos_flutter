import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/core/utils/stringbuffer.dart';
import 'package:product_app/features/product/presentation/states/product_details_state_provider.dart';
import 'package:product_app/features/product/presentation/viewmodels/product_details_viewmodel.dart';

class ProductDetailsPage extends ConsumerWidget{
  final ProductDetailsViewmodel viewmodel;
  const ProductDetailsPage({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plup = ref.watch(productDetailsStateNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text("Produto")),
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
                  viewmodel.returnImage(plup.produto!),
                  Text(
                    plup.produto!.title,
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
                            viewmodel.navigateToEditProduct(context, plup.produto!)
                          },
                          color: Colors.greenAccent,
                          icon: Icon(
                            Icons.edit,
                          )
                        ),
                        IconButton(
                          onPressed: () => {
                            viewmodel.changefav(plup.produto!)
                          },
                          color: viewmodel.fave(plup.produto!),
                          highlightColor: Colors.yellow,
                          icon: Icon(
                            Icons.star,
                          )
                        ),
                      ],
                    ) 
                  ),
                  
                  Text(
                    Stringbuffer.writeSumthing("R\$ ", plup.produto!.price.toString()),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  Text("Descrição do produto:"),
                  Text(plup.produto!.description),
                ],
              );
            }
          );
        }
      ),
    );
  }
}
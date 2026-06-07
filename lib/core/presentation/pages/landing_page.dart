import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/core/presentation/states/landing_page_state_provider.dart';
import 'package:product_app/core/presentation/viewmodels/landing_page_viewmodel.dart';

class LandingPage extends ConsumerWidget{
  final LandingPageViewmodel viewmodel;

  const LandingPage({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plop = ref.watch(landingPageStateNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text("Landing Page")),
      body: Builder(
        builder: (context) {
          if(plop.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }
          if(plop.error != null) {
            return Center(child: Text(plop.error!));
          }
          return Center(
            child: TextButton(
              onPressed: () {
                viewmodel.naivgate(context);
              },
              style: TextButton.styleFrom(
                side: BorderSide(
                  color: Colors.amber,
                  width: 2.0,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(6.7)),
              ),
              child: Text("Abrir Tela de Produtos")
            ),
          );
        }
      )
    );
  }
}
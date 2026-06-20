import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/core/presentation/states/login_page_state_provider.dart';
import 'package:product_app/core/presentation/viewmodels/login_page_viewmodel.dart';
import 'package:product_app/core/presentation/widgets/custom_input_field.dart';
import 'package:product_app/features/product/presentation/pages/product_page.dart';
import 'package:product_app/features/product/presentation/viewmodels/product_viewmodel.dart';

class LoginPage extends ConsumerWidget{
  final LoginPageViewmodel viewmodel;

  const LoginPage({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plop = ref.watch(loginPageStateNotifierProvider);
    viewmodel.syncControllers();
    viewmodel.checkLogin();
    
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Produtos-Mobile.com"))),
      body: Builder(
        builder: (context) {
          if(plop.sessao != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(loginPageStateNotifierProvider.notifier).changeLoading();
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => ProductPage(viewModel: ProductViewModel(ref))
                )
              );
            });
          }
          if(plop.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }
          if(plop.error != null) {
            return Center (
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 140,
                  maxWidth: 320,
                ),
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(plop.error?? "erro?"),
                    IconButton(
                      onPressed: () {viewmodel.reloadPage();},
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              )
            );
          }
          return ListView.builder(
            itemCount: 1,
            padding: EdgeInsetsGeometry.all(20.0),
            itemBuilder: (context, index) {
              return Column(
                spacing: 12,
                children: [
                  CustomInputField.createField(
                    labelText: "username",
                    controller: viewmodel.username,
                    onEditingComplete: () {viewmodel.updateControllers();},
                  ),
                  CustomInputField.createField(
                    labelText: "Senha",
                    controller: viewmodel.senha,
                    onEditingComplete: () {viewmodel.updateControllers();}
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        viewmodel.realizarLogin();
                      },
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: Colors.amber,
                          width: 2.0,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(6.7)),
                      ),
                      child: Text("Realizar Login")
                    ),
                  ),
                ],
              );
            },
          );
        }
      )
    );
  }
}
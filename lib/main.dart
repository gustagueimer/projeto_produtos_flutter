import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/core/presentation/pages/login_page.dart';
import 'package:product_app/core/presentation/viewmodels/login_page_viewmodel.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AppRoot()
    )
  );
}

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Product Listing 101',
      theme: ThemeData(useMaterial3: true),
      home: LoginPage(viewmodel: LoginPageViewmodel(ref))
    );
  }
}



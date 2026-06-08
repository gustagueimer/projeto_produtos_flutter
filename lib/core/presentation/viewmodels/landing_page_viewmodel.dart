import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:product_app/core/presentation/states/landing_page_state_provider.dart';
import 'package:product_app/features/product/presentation/pages/product_page.dart';
import 'package:product_app/features/product/presentation/viewmodels/product_viewmodel.dart';

class LandingPageViewmodel {
  final WidgetRef ref;

  LandingPageViewmodel(this.ref);

  void naivgate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ProductPage(viewModel: ProductViewModel(ref))
      )
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/core/presentation/states/landing_page_state.dart';

class LandingPageStateNotifier extends Notifier<LandingPageState>{

  @override
  LandingPageState build() {
    return LandingPageState();
  }

  void changeLoading() {
    if(state.isLoading) {
      state = state.copyWith(isLoading: false);
      return;
    }
    state = state.copyWith(isLoading: true);
  }

   void changeError(String error) {
    state = state.copyWith(error: error);
  }
}

final landingPageStateNotifierProvider = NotifierProvider<LandingPageStateNotifier, LandingPageState>(() {
  return LandingPageStateNotifier();
});
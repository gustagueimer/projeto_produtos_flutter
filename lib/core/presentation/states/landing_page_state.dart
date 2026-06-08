class LandingPageState { 
  final bool isLoading;
  final String? error;

  const LandingPageState({
    this.isLoading = false,
    this.error,
  });

  LandingPageState copyWith({
    bool? isLoading,
    String? error
  }) {
    return LandingPageState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
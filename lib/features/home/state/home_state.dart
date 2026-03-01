import '../../quotes/models/quote.dart';

class HomeState {
  final bool isLoading;
  final List<Quote> quotes;
  final Quote? currentQuote;
  final bool isFavorite;

  const HomeState({
    required this.isLoading,
    required this.quotes,
    required this.currentQuote,
    required this.isFavorite,
  });

  factory HomeState.initial() => const HomeState(
        isLoading: true,
        quotes: [],
        currentQuote: null,
        isFavorite: false,
      );

  HomeState copyWith({
    bool? isLoading,
    List<Quote>? quotes,
    Quote? currentQuote,
    bool? isFavorite,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      quotes: quotes ?? this.quotes,
      currentQuote: currentQuote ?? this.currentQuote,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
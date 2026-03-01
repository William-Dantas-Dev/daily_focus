import 'dart:math';
import '../models/quote.dart';

class QuotePicker {
  QuotePicker._();

  static Quote random(List<Quote> quotes, {Quote? exclude}) {
    if (quotes.isEmpty) {
      return const Quote(
        id: -1,
        text: 'Sem frases disponíveis.',
        author: 'Daily Focus',
        category: 'INFO',
      );
    }

    final rng = Random();
    if (quotes.length == 1) return quotes.first;

    Quote picked;
    do {
      picked = quotes[rng.nextInt(quotes.length)];
    } while (exclude != null && picked.id == exclude.id);

    return picked;
  }

  /// Pega uma frase que ainda não foi vista (com reset automático se acabou).
  static Quote nextUnseen({
    required List<Quote> quotes,
    required Set<int> seenIds,
    Quote? exclude,
  }) {
    if (quotes.isEmpty) {
      return const Quote(
        id: -1,
        text: 'Sem frases disponíveis.',
        author: 'Daily Focus',
        category: 'INFO',
      );
    }

    final unseen = quotes.where((q) => !seenIds.contains(q.id)).toList();
    final pool = unseen.isEmpty ? quotes : unseen;

    return random(pool, exclude: exclude);
  }
}
import 'dart:math';
import '../models/quote.dart';

class QuotePicker {
  QuotePicker._();

  static Quote random(List<Quote> quotes, {Quote? exclude}) {
    if (quotes.isEmpty) {
      return const Quote(
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
    } while (exclude != null &&
        picked.text == exclude.text &&
        picked.author == exclude.author &&
        picked.source == exclude.source);

    return picked;
  }
}
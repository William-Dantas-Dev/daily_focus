import 'quote.dart';

class QuotePack {
  final int version;
  final String updatedAt;
  final List<Quote> quotes;

  const QuotePack({
    required this.version,
    required this.updatedAt,
    required this.quotes,
  });

  factory QuotePack.fromJson(Map<String, dynamic> json) {
    final rawQuotes = json['quotes'];

    final quotesList = (rawQuotes is List)
        ? rawQuotes
            .whereType<Map>()
            .map((e) => Quote.fromJson(Map<String, dynamic>.from(e)))
            .where((q) => q.id >= 0 && q.text.trim().isNotEmpty)
            .toList()
        : <Quote>[];

    return QuotePack(
      version: (json['version'] is int) ? json['version'] as int : 1,
      updatedAt: (json['updated_at'] ?? '').toString(),
      quotes: quotesList,
    );
  }
}
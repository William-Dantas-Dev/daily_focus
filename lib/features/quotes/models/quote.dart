class Quote {
  final String text;
  final String author;
  final String category;
  final String? source;

  const Quote({
    required this.text,
    required this.author,
    required this.category,
    this.source,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    final rawSource = json['source'];
    final source = rawSource?.toString().trim();

    return Quote(
      text: (json['text'] ?? '').toString(),
      author: (json['author'] ?? '').toString(),
      category: (json['category'] ?? '').toString(),
      source: (source == null || source.isEmpty) ? null : source,
    );
  }
}

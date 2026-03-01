class Quote {
  final int id;
  final String text;
  final String author;
  final String category;
  final String? source;

  const Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
    this.source,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    final id = rawId is int ? rawId : int.tryParse(rawId.toString()) ?? -1;

    final rawSource = json['source'];
    final source = rawSource?.toString().trim();

    return Quote(
      id: id,
      text: (json['text'] ?? '').toString(),
      author: (json['author'] ?? '').toString(),
      category: (json['category'] ?? '').toString(),
      source: (source == null || source.isEmpty) ? null : source,
    );
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/quote_pack.dart';

class QuoteRemoteService {
  QuoteRemoteService._();

  static const String quotesUrl =
      'https://raw.githubusercontent.com/William-Dantas-Dev/daily_focus_content/main/quotes/quotes_pt.json';

  static Future<QuotePack> fetchPack({
    Duration timeout = const Duration(seconds: 8),
  }) async {
    final uri = Uri.parse(quotesUrl);
    final res = await http.get(uri).timeout(timeout);

    if (res.statusCode != 200) {
      throw Exception('Falha ao buscar quotes: HTTP ${res.statusCode}');
    }

    final decoded = jsonDecode(res.body);
    if (decoded is! Map<String, dynamic>) {
      throw FormatException('JSON remoto inválido: esperado objeto.');
    }

    return QuotePack.fromJson(decoded);
  }
}
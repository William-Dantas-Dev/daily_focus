import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/quote_pack.dart';

class QuoteAssetService {
  QuoteAssetService._();

  static const String assetPath = 'assets/quotes/quotes_pt.json';

  static Future<QuotePack> loadPack() async {
    final raw = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(raw);

    if (decoded is! Map<String, dynamic>) {
      throw FormatException('Asset JSON inválido: esperado objeto.');
    }

    return QuotePack.fromJson(decoded);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class QuoteProgressService {
  QuoteProgressService._();

  static const _kLastDate = 'quotes_last_date'; // YYYY-MM-DD
  static const _kTodayQuoteId = 'quotes_today_quote_id'; // int
  static const _kSeenIds = 'quotes_seen_ids'; // List<String> de ids

  static String todayKey() {
    final now = DateTime.now();
    return '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }

  static Future<String?> getLastDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLastDate);
  }

  static Future<int?> getTodayQuoteId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kTodayQuoteId);
  }

  static Future<void> setTodayQuote({
    required String dateKey,
    required int quoteId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLastDate, dateKey);
    await prefs.setInt(_kTodayQuoteId, quoteId);
  }

  static Future<Set<int>> getSeenIds() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kSeenIds) ?? const <String>[];
    return list.map((e) => int.tryParse(e)).whereType<int>().toSet();
  }

  static Future<void> setSeenIds(Set<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kSeenIds, ids.map((e) => e.toString()).toList());
  }

  static Future<void> markSeen(int quoteId) async {
    final ids = await getSeenIds();
    ids.add(quoteId);
    await setSeenIds(ids);
  }

  static Future<void> resetSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kSeenIds);
  }
}
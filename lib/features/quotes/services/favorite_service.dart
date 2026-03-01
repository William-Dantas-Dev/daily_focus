import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const _kFavKey = 'favorite_quote_ids';

  static Future<Set<int>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kFavKey) ?? <String>[];
    return list.map(int.parse).toSet();
  }

  static Future<bool> isFavorite(int quoteId) async {
    final ids = await getFavoriteIds();
    return ids.contains(quoteId);
  }

  static Future<void> add(int quoteId) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = await getFavoriteIds();
    ids.add(quoteId);
    await prefs.setStringList(_kFavKey, ids.map((e) => e.toString()).toList());
  }

  static Future<void> remove(int quoteId) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = await getFavoriteIds();
    ids.remove(quoteId);
    await prefs.setStringList(_kFavKey, ids.map((e) => e.toString()).toList());
  }

  static Future<bool> toggle(int quoteId) async {
    final ids = await getFavoriteIds();
    final nowFav = !ids.contains(quoteId);

    if (nowFav) {
      ids.add(quoteId);
    } else {
      ids.remove(quoteId);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kFavKey, ids.map((e) => e.toString()).toList());
    return nowFav;
  }
}
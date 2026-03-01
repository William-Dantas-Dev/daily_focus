import 'package:shared_preferences/shared_preferences.dart';

class QuoteCacheService {
  QuoteCacheService._();

  static const _kPackJson = 'quotes_pack_json';
  static const _kPackVersion = 'quotes_pack_version';
  static const _kPackUpdatedAt = 'quotes_pack_updated_at';

  static Future<void> savePack({
    required String rawJson,
    required int version,
    required String updatedAt,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPackJson, rawJson);
    await prefs.setInt(_kPackVersion, version);
    await prefs.setString(_kPackUpdatedAt, updatedAt);
  }

  static Future<String?> loadRawJson() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kPackJson);
  }

  static Future<int?> loadVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kPackVersion);
  }

  static Future<String?> loadUpdatedAt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kPackUpdatedAt);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kPackJson);
    await prefs.remove(_kPackVersion);
    await prefs.remove(_kPackUpdatedAt);
  }
}
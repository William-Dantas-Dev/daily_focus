import 'dart:convert';

import '../models/quote_pack.dart';
import '../services/quote_asset_service.dart';
import '../services/quote_cache_service.dart';
import '../services/quote_remote_service.dart';

class QuoteRepository {
  QuoteRepository();

  /// Carrega rápido:
  /// 1) cache local (se existir)
  /// 2) senão asset local
  Future<QuotePack> getInitialPack() async {
    final cachedRaw = await QuoteCacheService.loadRawJson();
    if (cachedRaw != null && cachedRaw.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(cachedRaw);
        if (decoded is Map<String, dynamic>) {
          return QuotePack.fromJson(decoded);
        }
      } catch (_) {
        // cache corrompido -> cai pro asset
      }
    }

    return QuoteAssetService.loadPack();
  }

  /// Sincroniza com o GitHub:
  /// - se a versão/updated_at mudou, salva no cache e retorna o novo pack
  /// - se não mudou, retorna null
  Future<QuotePack?> syncIfNeeded() async {
    final cachedVersion = await QuoteCacheService.loadVersion();
    final cachedUpdatedAt = await QuoteCacheService.loadUpdatedAt();

    final remote = await QuoteRemoteService.fetchPack();

    final remoteVersion = remote.pack.version;
    final remoteUpdatedAt = remote.pack.updatedAt;

    final changed = (cachedVersion == null || cachedUpdatedAt == null)
        ? true
        : (remoteVersion != cachedVersion || remoteUpdatedAt != cachedUpdatedAt);

    if (!changed) return null;

    await QuoteCacheService.savePack(
      rawJson: remote.rawJson,
      version: remoteVersion,
      updatedAt: remoteUpdatedAt,
    );

    return remote.pack;
  }
}
import '../models/quote_pack.dart';
import '../services/quote_asset_service.dart';
import '../services/quote_remote_service.dart';

class QuoteRepository {
  QuoteRepository();

  Future<QuotePack> getPack() async {
    try {
      return await QuoteRemoteService.fetchPack();
    } catch (_) {
      // Fallback offline/erro
      return QuoteAssetService.loadPack();
    }
  }
}
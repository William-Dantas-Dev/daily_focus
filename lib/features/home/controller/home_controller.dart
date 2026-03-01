import 'package:flutter/material.dart';

import '../../quotes/models/quote.dart';
import '../../quotes/repository/quote_repository.dart';
import '../../quotes/services/quote_picker.dart';
import '../../quotes/services/quote_progress_service.dart';
import '../../quotes/services/favorite_service.dart';
import '../state/home_state.dart';

class HomeController {
  final QuoteRepository _repo;

  final ValueNotifier<HomeState> state = ValueNotifier(HomeState.initial());

  HomeController({QuoteRepository? repo}) : _repo = repo ?? QuoteRepository();

  Future<void> boot() async {
    // 1) abre rápido com cache/asset
    final initial = await _repo.getInitialPack();
    state.value = state.value.copyWith(
      quotes: initial.quotes,
      isLoading: false,
    );

    // 2) escolhe/restaura frase do dia
    await _ensureTodayQuote();

    // 3) sincroniza remoto
    try {
      final updated = await _repo.syncIfNeeded();
      if (updated != null) {
        state.value = state.value.copyWith(quotes: updated.quotes);
        await _ensureTodayQuote(); // revalida ID salvo
      }
    } catch (_) {
      // offline/erro -> segue
    }
  }

  Future<void> newQuote() async {
    final s = state.value;
    if (s.isLoading || s.quotes.isEmpty) return;

    final seenIds = await QuoteProgressService.getSeenIds();
    final allIds = s.quotes.map((q) => q.id).toSet();
    final unseen = allIds.difference(seenIds);

    Set<int> effectiveSeen = seenIds;
    if (unseen.isEmpty) {
      effectiveSeen = <int>{};
      await QuoteProgressService.resetSeen();
    }

    final next = QuotePicker.nextUnseen(
      quotes: s.quotes,
      seenIds: effectiveSeen,
      exclude: s.currentQuote,
    );

    final today = QuoteProgressService.todayKey();
    await QuoteProgressService.markSeen(next.id);
    await QuoteProgressService.setTodayQuote(dateKey: today, quoteId: next.id);

    state.value = state.value.copyWith(currentQuote: next);
    await _refreshFavoriteFlag();
  }

  Future<void> toggleFavorite() async {
    final q = state.value.currentQuote;
    if (q == null || q.id < 0) return;

    final nowFav = await FavoriteService.toggle(q.id);
    state.value = state.value.copyWith(isFavorite: nowFav);
  }

  Future<void> _ensureTodayQuote() async {
    final s = state.value;

    if (s.quotes.isEmpty) {
      state.value = s.copyWith(
        currentQuote: const Quote(
          id: -1,
          text: 'Sem frases disponíveis.',
          author: 'Daily Focus',
          category: 'INFO',
        ),
        isFavorite: false,
      );
      return;
    }

    final today = QuoteProgressService.todayKey();
    final lastDate = await QuoteProgressService.getLastDate();
    final savedId = await QuoteProgressService.getTodayQuoteId();
    final seenIds = await QuoteProgressService.getSeenIds();

    Quote? resolved;

    // mesmo dia: tenta restaurar por ID
    if (lastDate == today && savedId != null) {
      resolved = s.quotes.cast<Quote?>().firstWhere(
            (q) => q?.id == savedId,
            orElse: () => null,
          );
    }

    // se mudou o dia (ou ID não existe mais): pega não-vista
    if (resolved == null) {
      final allIds = s.quotes.map((q) => q.id).toSet();
      final hasUnseen = allIds.difference(seenIds).isNotEmpty;

      Set<int> effectiveSeen = seenIds;
      if (!hasUnseen) {
        effectiveSeen = <int>{};
        await QuoteProgressService.resetSeen();
      }

      resolved = QuotePicker.nextUnseen(
        quotes: s.quotes,
        seenIds: effectiveSeen,
        exclude: s.currentQuote,
      );

      await QuoteProgressService.markSeen(resolved.id);
      await QuoteProgressService.setTodayQuote(dateKey: today, quoteId: resolved.id);
    }

    state.value = state.value.copyWith(currentQuote: resolved);
    await _refreshFavoriteFlag();
  }

  Future<void> _refreshFavoriteFlag() async {
    final q = state.value.currentQuote;
    if (q == null || q.id < 0) {
      state.value = state.value.copyWith(isFavorite: false);
      return;
    }

    final fav = await FavoriteService.isFavorite(q.id);
    state.value = state.value.copyWith(isFavorite: fav);
  }

  void dispose() {
    state.dispose();
  }
}
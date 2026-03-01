import 'package:flutter/material.dart';

import '../quotes/models/quote.dart';
import '../quotes/repository/quote_repository.dart';
import '../quotes/services/favorite_service.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    super.key,
    this.onGoHome,
  });

  /// Opcional: se você estiver usando abas, passa um callback pra voltar pra Home.
  final VoidCallback? onGoHome;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final QuoteRepository _repo = QuoteRepository();

  bool _isLoading = true;

  List<Quote> _allQuotes = const [];
  Set<int> _favoriteIds = <int>{};

  String _selectedCategory = 'Todas';

  @override
  void initState() {
    super.initState();
    _boot();
  }

  Future<void> _boot() async {
    try {
      // 1) pack inicial rápido
      final initial = await _repo.getInitialPack();
      if (!mounted) return;

      _allQuotes = initial.quotes;
      _favoriteIds = await FavoriteService.getFavoriteIds();

      setState(() => _isLoading = false);

      // 2) sync remoto (se houver)
      try {
        final updated = await _repo.syncIfNeeded();
        if (!mounted) return;

        if (updated != null) {
          _allQuotes = updated.quotes;
          _favoriteIds = await FavoriteService.getFavoriteIds();
          setState(() {});
        }
      } catch (_) {
        // offline/erro -> segue
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  List<Quote> get _favoriteQuotes {
    if (_favoriteIds.isEmpty || _allQuotes.isEmpty) return const [];
    final favs = _allQuotes.where((q) => _favoriteIds.contains(q.id)).toList();

    if (_selectedCategory == 'Todas') return favs;

    return favs
        .where((q) => (q.category).toLowerCase() == _selectedCategory.toLowerCase())
        .toList();
  }

  List<String> get _availableCategories {
    final favs = _allQuotes.where((q) => _favoriteIds.contains(q.id));
    final set = <String>{};
    for (final q in favs) {
      if (q.category.trim().isNotEmpty) set.add(q.category.trim());
    }
    final list = set.toList()..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return ['Todas', ...list];
  }

  Future<void> _removeFavorite(Quote q) async {
    await FavoriteService.remove(q.id);
    final ids = await FavoriteService.getFavoriteIds();

    if (!mounted) return;
    setState(() => _favoriteIds = ids);

    // Se o filtro atual ficar inválido (sem itens), mantém o filtro, mas a lista pode ficar vazia.
    // Você pode opcionalmente resetar para "Todas" quando ficar vazia:
    // if (_favoriteQuotes.isEmpty && _selectedCategory != 'Todas') setState(() => _selectedCategory = 'Todas');
  }

  @override
  Widget build(BuildContext context) {
    final categories = _availableCategories;
    final favQuotes = _favoriteQuotes;

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF070A1A), Color(0xFF05071A), Color(0xFF040515)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(),
                const SizedBox(height: 16),

                // Chips
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, i) {
                      final label = categories[i];
                      final selected = label.toLowerCase() == _selectedCategory.toLowerCase();
                      return _CategoryChip(
                        label: label,
                        selected: selected,
                        onTap: () => setState(() => _selectedCategory = label),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 14),

                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : (_favoriteIds.isEmpty
                          ? _EmptyState(onGoHome: widget.onGoHome)
                          : (favQuotes.isEmpty
                              ? _EmptyFilteredState(
                                  selectedCategory: _selectedCategory,
                                  onClearFilter: () => setState(() => _selectedCategory = 'Todas'),
                                )
                             
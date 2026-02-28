import 'package:flutter/material.dart';

import './widgets/bottom_navigation.dart';
import './widgets/home_header.dart';
import './widgets/quote_card.dart';
import './widgets/home_actions.dart';

import '../quotes/models/quote.dart';
import '../quotes/repository/quote_repository.dart';
import '../quotes/services/quote_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final String _subtitle = 'Seu foco de hoje';

  final QuoteRepository _repo = QuoteRepository();

  bool _isLoading = true;
  List<Quote> _quotes = const [];
  Quote? _currentQuote;

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  Future<void> _loadQuotes() async {
    try {
      final pack = await _repo.getPack();
      final loaded = pack.quotes;

      if (!mounted) return;

      setState(() {
        _quotes = loaded;
        _currentQuote = QuotePicker.random(_quotes);
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _quotes = const [];
        _currentQuote = const Quote(
          text: 'Não foi possível carregar as frases agora.',
          author: 'Daily Focus',
          category: 'INFO',
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha ao carregar frases. Verifique sua conexão.'),
        ),
      );
    }
  }

  void _newQuote() {
    if (_isLoading) return;

    final next = QuotePicker.random(_quotes, exclude: _currentQuote);
    setState(() => _currentQuote = next);
  }

  String _formatDatePt(DateTime date) {
    const months = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];
    final monthName = months[date.month - 1];
    return '${date.day} de $monthName';
  }

  @override
  Widget build(BuildContext context) {
    final dateText = _formatDatePt(DateTime.now());
    final quote = _currentQuote;

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
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(dateText: dateText, subtitle: _subtitle),
                const SizedBox(height: 28),

                Expanded(
                  child: _isLoading
                      ? const _QuoteLoading()
                      : AnimatedSwitcher(
                          duration: const Duration(milliseconds: 260),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          transitionBuilder: (child, animation) {
                            final fade = FadeTransition(
                              opacity: animation,
                              child: child,
                            );

                            final slide = SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.03),
                                end: Offset.zero,
                              ).animate(animation),
                              child: fade,
                            );

                            return slide;
                          },
                          child: QuoteCard(
                            key: ValueKey(
                              '${quote?.text ?? ''}-${quote?.author ?? ''}-${quote?.source ?? ''}',
                            ),
                            category: quote?.category ?? 'INFO',
                            quote: quote?.text ?? '',
                            author: quote?.author ?? '',
                            source: quote?.source,
                          ),
                        ),
                ),

                const SizedBox(height: 18),

                HomeActions(
                  onNewQuote: _newQuote,
                  onLike: () {
                    // próximo passo: favoritar (cache local)
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _QuoteLoading extends StatelessWidget {
  const _QuoteLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F2A).withOpacity(0.65),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFF6C7BFF).withOpacity(0.10),
          width: 1,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.4,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}

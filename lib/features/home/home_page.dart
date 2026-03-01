import 'package:flutter/material.dart';

import './widgets/quote_loading.dart';
import './widgets/home_header.dart';
import './widgets/quote_card.dart';
import './widgets/home_actions.dart';

import '../quotes/models/quote.dart';
import './controller/home_controller.dart';
import './state/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _subtitle = 'Seu foco de hoje';

  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController();
    _controller.boot();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDatePt(DateTime date) {
    const months = [
      'Janeiro','Fevereiro','Março','Abril','Maio','Junho',
      'Julho','Agosto','Setembro','Outubro','Novembro','Dezembro',
    ];
    return '${date.day} de ${months[date.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final dateText = _formatDatePt(DateTime.now());

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
            child: ValueListenableBuilder<HomeState>(
              valueListenable: _controller.state,
              builder: (context, s, _) {
                final Quote? q = s.currentQuote;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(dateText: dateText, subtitle: _subtitle),
                    const SizedBox(height: 28),
                    Expanded(
                      child: (s.isLoading || q == null)
                          ? const QuoteLoading()
                          : AnimatedSwitcher(
                              duration: const Duration(milliseconds: 260),
                              switchInCurve: Curves.easeOut,
                              switchOutCurve: Curves.easeIn,
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 0.03),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  ),
                                );
                              },
                              child: QuoteCard(
                                key: ValueKey(q.id),
                                category: q.category,
                                quote: q.text,
                                author: q.author,
                                source: q.source,
                              ),
                            ),
                    ),
                    const SizedBox(height: 18),
                    HomeActions(
                      onNewQuote: _controller.newQuote,
                      onLike: _controller.toggleFavorite,
                      isFavorite: s.isFavorite,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    super.key,
    required this.category,
    required this.quote,
    required this.author,
    this.source,
  });

  final String category;
  final String quote;
  final String author;
  final String? source;

  @override
  Widget build(BuildContext context) {
    final authorLine = (source != null && source!.trim().isNotEmpty)
        ? '$author • ${source!.trim()}'
        : author;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFF6C7BFF).withValues(alpha: 0.14),
          width: 1,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0A0F2A).withValues(alpha: 0.78),
            const Color(0xFF070B1F).withValues(alpha: 0.72),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 22,
            offset: const Offset(0, 14),
          ),
          BoxShadow(
            color: const Color(0xFF6C7BFF).withValues(alpha: 0.06),
            blurRadius: 28,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        children: [
          const Spacer(flex: 4),

          Text(
            category.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 3.2,
              color: const Color(0xFF6C7BFF).withValues(alpha: 0.95),
            ),
          ),

          const SizedBox(height: 18),

          Text(
            quote,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              height: 1.28,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            authorLine,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
              color: Colors.white.withValues(alpha: 0.55),
            ),
          ),

          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
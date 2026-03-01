import 'package:flutter/material.dart';

class HomeActions extends StatelessWidget {
  const HomeActions({
    super.key,
    required this.onNewQuote,
    required this.onLike,
    required this.isFavorite,
  });

  final VoidCallback onNewQuote;
  final VoidCallback onLike;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: onNewQuote,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFF0D1230),
                    foregroundColor: Colors.white.withValues(alpha: 0.92),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.06),
                        width: 1,
                      ),
                    ),
                  ),
                  icon: Icon(
                    Icons.refresh_rounded,
                    size: 18,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                  label: const Text(
                    'Nova frase',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 52,
              height: 44,
              child: ElevatedButton(
                onPressed: onLike,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF0D1230),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.06),
                      width: 1,
                    ),
                  ),
                ),
                child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, size: 18),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

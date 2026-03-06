import 'package:flutter/material.dart';

class PulseCircle extends StatelessWidget {
  const PulseCircle({
    super.key,
    required this.size,
    required this.color,
    required this.scale,
    this.borderWidth = 2,
  });

  final double size;
  final Color color;
  final Animation<double> scale;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: borderWidth),
        ),
      ),
    );
  }
}

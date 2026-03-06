import 'package:flutter/material.dart';
import 'pulse_circle.dart';

class FocusPulseLogo extends StatefulWidget {
  const FocusPulseLogo({super.key, this.color = Colors.blue});

  final Color color;

  @override
  State<FocusPulseLogo> createState() => _FocusPulseLogoState();
}

class _FocusPulseLogoState extends State<FocusPulseLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulse = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.color;

    return Stack(
      alignment: Alignment.center,
      children: [
        PulseCircle(size: 90, color: c.withValues(alpha: 0.2), scale: _pulse),
        PulseCircle(size: 60, color: c.withValues(alpha: 0.4), scale: _pulse),
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(color: c, shape: BoxShape.circle),
        ),
      ],
    );
  }
}

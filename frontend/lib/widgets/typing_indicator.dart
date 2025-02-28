import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(0),
        SizedBox(width: 4),
        _buildDot(1),
        SizedBox(width: 4),
        _buildDot(2),
      ],
    );
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final delay = index * 0.3;
        final progress = (_controller.value + delay) % 1.0;
        final size = 4 + (progress < 0.5 ? progress : 1 - progress) * 4;
        
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: RafikiTheme.primaryColor,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isOperator;
  final bool isFunction;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isOperator = false,
    this.isFunction = false,
  });

  Color get _backgroundColor {
    if (label == '=') return AppTheme.equalsColor;
    if (isOperator) return AppTheme.operatorColor.withOpacity(0.2);
    if (isFunction) return AppTheme.surfaceColor;
    return AppTheme.buttonColor;
  }

  Color get _textColor {
    if (label == '=') return Colors.white;
    if (isOperator) return AppTheme.accentColor;
    if (isFunction) return AppTheme.accentColor;
    return AppTheme.textColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: _textColor,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ).animate(onPlay: (c) => c.reset()).scaleXY(
              end: 0.95,
              duration: 100.ms,
            ),
      ),
    );
  }
}
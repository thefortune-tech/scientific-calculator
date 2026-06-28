import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/calculation.dart';

class HistoryItem extends StatelessWidget {
  final Calculation calculation;

  const HistoryItem({super.key, required this.calculation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            calculation.expression,
            style: const TextStyle(
              color: AppTheme.subTextColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '= ${calculation.result}',
            style: const TextStyle(
              color: AppTheme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${calculation.timestamp.day}/${calculation.timestamp.month}/${calculation.timestamp.year} ${calculation.timestamp.hour}:${calculation.timestamp.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(
              color: AppTheme.subTextColor,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
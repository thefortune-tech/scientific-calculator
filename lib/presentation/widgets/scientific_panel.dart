import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';
import 'calculator_button.dart';

class ScientificPanel extends StatelessWidget {
  const ScientificPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CalculatorBloc>();

    final functions = [
      ['sin(', 'cos(', 'tan(', 'π'],
      ['sinh(', 'cosh(', 'tanh(', 'e'],
      ['log(', 'ln(', 'sqrt(', '^'],
      ['(', ')', 'n!', 'C('],
    ];

    return Container(
      color: AppTheme.surfaceColor.withValues(alpha: 0.5),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: functions.map((row) {
          return SizedBox(
            height: 52,
            child: Row(
              children: row.map((label) {
                return Expanded(
                  child: CalculatorButton(
                    label: label,
                    onTap: () {
                      bloc.add(ButtonPressed(value: label));
                    },
                    isFunction: true,
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
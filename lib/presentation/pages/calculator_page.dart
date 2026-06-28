import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/router/app_router.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';
import '../bloc/calculator_state.dart';
import '../widgets/calculator_button.dart';
import '../widgets/calculator_display.dart';
import '../widgets/scientific_panel.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  bool _showScientific = false;

  @override
  void initState() {
    super.initState();
    context.read<CalculatorBloc>().add(const HistoryLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('ScientIQ'),
       actions: [
  BlocBuilder<CalculatorBloc, CalculatorState>(
    builder: (context, state) {
      final isDegree = state is CalculatorUpdated ? state.isDegree : true;
      return TextButton(
        onPressed: () {
          context.read<CalculatorBloc>().add(const ToggleDegreeMode());
        },
        child: Text(
          isDegree ? 'DEG' : 'RAD',
          style: const TextStyle(
            color: AppTheme.accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    },
  ),
  IconButton(
    icon: Icon(
      _showScientific ? Icons.calculate : Icons.science,
      color: AppTheme.accentColor,
    ),
    onPressed: () {
      setState(() {
        _showScientific = !_showScientific;
      });
    },
  ),
  IconButton(
    icon: const Icon(Icons.history, color: AppTheme.accentColor),
    onPressed: () => context.push(AppRouter.history),
  ),
],
      ),
      body: BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          String expression = '';
          String result = '0';

          if (state is CalculatorUpdated) {
            expression = state.expression;
            result = state.result;
          }

          return Column(
            children: [
              CalculatorDisplay(
                expression: expression,
                result: result,
              ),
              if (_showScientific) const ScientificPanel(),
              const Expanded(child: BasicPanel()),
            ],
          );
        },
      ),
    );
  }
}

class BasicPanel extends StatelessWidget {
  const BasicPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CalculatorBloc>();

    final buttons = [
      ['C', '±', '%', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', '⌫', '='],
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: buttons.map((row) {
          return Expanded(
            child: Row(
              children: row.map((label) {
                return Expanded(
                  child: CalculatorButton(
                    label: label,
                    onTap: () {
                      if (label == '=') {
                        bloc.add(const EvaluatePressed());
                      } else if (label == 'C') {
                        bloc.add(const ClearPressed());
                      } else if (label == '⌫') {
                        bloc.add(const BackspacePressed());
                      } else {
                        bloc.add(ButtonPressed(value: label));
                      }
                    },
                    isOperator: ['÷', '×', '-', '+', '='].contains(label),
                    isFunction: ['C', '±', '%'].contains(label),
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
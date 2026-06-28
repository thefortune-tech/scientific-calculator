import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';
import '../bloc/calculator_state.dart';
import '../widgets/history_item.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: AppTheme.accentColor),
            onPressed: () {
              context.read<CalculatorBloc>().add(const HistoryCleared());
            },
          ),
        ],
      ),
      body: BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          if (state is CalculatorUpdated && state.history.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                final calculation = state.history[index];
                return HistoryItem(calculation: calculation);
              },
            );
          }
          return const Center(
            child: Text(
              'No history yet',
              style: TextStyle(color: AppTheme.subTextColor, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
import 'package:equatable/equatable.dart';
import '../../domain/entities/calculation.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

class CalculatorInitial extends CalculatorState {
  const CalculatorInitial();
}

class CalculatorUpdated extends CalculatorState {
  final String expression;
  final String result;
  final List<Calculation> history;
  final bool isDegree;

  const CalculatorUpdated({
    required this.expression,
    required this.result,
    required this.history,
    this.isDegree=true,
  });

  @override
  List<Object> get props => [expression, result, history,isDegree];

  CalculatorUpdated copyWith({
    String? expression,
    String? result,
    List<Calculation>? history,
    bool? isDegree,
  }) {
    return CalculatorUpdated(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      history: history ?? this.history,
      isDegree: isDegree?? this.isDegree,
    );
  }
}

class CalculatorError extends CalculatorState {
  final String message;

  const CalculatorError({required this.message});

  @override
  List<Object> get props => [message];
}

class CalculatorLoading extends CalculatorState {
  const CalculatorLoading();
}
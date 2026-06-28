import 'package:equatable/equatable.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class ButtonPressed extends CalculatorEvent {
  final String value;

  const ButtonPressed({required this.value});

  @override
  List<Object> get props => [value];
}

class EvaluatePressed extends CalculatorEvent {
  const EvaluatePressed();
}

class ClearPressed extends CalculatorEvent {
  const ClearPressed();
}

class BackspacePressed extends CalculatorEvent {
  const BackspacePressed();
}

class HistoryLoaded extends CalculatorEvent {
  const HistoryLoaded();
}

class HistoryCleared extends CalculatorEvent {
  const HistoryCleared();
}

class CalculationDeleted extends CalculatorEvent {
  final String id;

  const CalculationDeleted({required this.id});

  @override
  List<Object> get props => [id];
}
class ToggleDegreeMode extends CalculatorEvent {
  const ToggleDegreeMode();
}
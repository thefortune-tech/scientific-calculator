import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/calculation.dart';
import '../../domain/repositories/calculator_repository.dart';
import '../../domain/usecases/clear_history.dart';
import '../../domain/usecases/evaluate_expression.dart';
import '../../domain/usecases/get_history.dart';
import '../../domain/usecases/save_calculation.dart';
import '../../core/usecases/usecase.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';


class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final EvaluateExpression evaluateExpression;
  final SaveCalculation saveCalculation;
  final GetHistory getHistory;
  final ClearHistory clearHistory;
  final CalculatorRepository repository;

  String _expression = '';
  String _result = '0';
  List<Calculation> _history = [];
  bool _isDegree = true;

  CalculatorBloc({
    required this.evaluateExpression,
    required this.saveCalculation,
    required this.getHistory,
    required this.clearHistory,
    required this.repository,
  }) : super(const CalculatorInitial()) {
    on<ButtonPressed>(_onButtonPressed);
    on<EvaluatePressed>(_onEvaluatePressed);
    on<ClearPressed>(_onClearPressed);
    on<BackspacePressed>(_onBackspacePressed);
    on<HistoryLoaded>(_onHistoryLoaded);
    on<HistoryCleared>(_onHistoryCleared);
    on<CalculationDeleted>(_onCalculationDeleted);
    on<ToggleDegreeMode>(_onToggleDegreeMode);
  }

  void _onButtonPressed(ButtonPressed event, Emitter<CalculatorState> emit) {
    _expression += event.value;
    emit(CalculatorUpdated(
      expression: _expression,
      result: _result,
      history: _history,
      isDegree: _isDegree,
    ));
  }

  Future<void> _onEvaluatePressed(
    EvaluatePressed event,
    Emitter<CalculatorState> emit,
  ) async {
    if (_expression.isEmpty) return;
    emit(const CalculatorLoading());

    final result = await evaluateExpression(
      EvaluateParams(expression: _expression),
    );

    _result = result;

    final calculation = Calculation(
      id: const Uuid().v4(),
      expression: _expression,
      result: result,
      timestamp: DateTime.now(),
    );

    await saveCalculation(SaveCalculationParams(calculation: calculation));
    _history = await getHistory(NoParams());
    _expression = result == 'Error' ? _expression : result;

    emit(CalculatorUpdated(
      expression: _expression,
      result: _result,
      history: _history,
      isDegree: _isDegree,
    ));
  }

  void _onClearPressed(ClearPressed event, Emitter<CalculatorState> emit) {
    _expression = '';
    _result = '0';
    emit(CalculatorUpdated(
      expression: _expression,
      result: _result,
      history: _history,
      isDegree: _isDegree,
    ));
  }

  void _onBackspacePressed(
    BackspacePressed event,
    Emitter<CalculatorState> emit,
  ) {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      emit(CalculatorUpdated(
        expression: _expression,
        result: _result,
        history: _history,
        isDegree: _isDegree,
      ));
    }
  }

  Future<void> _onHistoryLoaded(
    HistoryLoaded event,
    Emitter<CalculatorState> emit,
  ) async {
    _history = await getHistory(NoParams());
    emit(CalculatorUpdated(
      expression: _expression,
      result: _result,
      history: _history,
      isDegree: _isDegree,
    ));
  }

  Future<void> _onHistoryCleared(
    HistoryCleared event,
    Emitter<CalculatorState> emit,
  ) async {
    await clearHistory(NoParams());
    _history = [];
    emit(CalculatorUpdated(
      expression: _expression,
      result: _result,
      history: _history,
      isDegree: _isDegree,
    ));
  }

  Future<void> _onCalculationDeleted(
    CalculationDeleted event,
    Emitter<CalculatorState> emit,
  ) async {
    _history = await getHistory(NoParams());
    emit(CalculatorUpdated(
      expression: _expression,
      result: _result,
      history: _history,
      isDegree: _isDegree,
    ));
  }

  void _onToggleDegreeMode(
    ToggleDegreeMode event,
    Emitter<CalculatorState> emit,
  ) {
    _isDegree = !_isDegree;
    repository.setDegreeMode(_isDegree);
    emit(CalculatorUpdated(
      expression: _expression,
      result: _result,
      history: _history,
      isDegree: _isDegree,
    ));
  }
}
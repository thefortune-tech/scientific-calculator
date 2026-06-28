import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';
import '../../core/utils/calculator_utils.dart';
import '../../domain/entities/calculation.dart';
import '../../domain/repositories/calculator_repository.dart';
import '../datasources/calculator_local_datasource.dart';
import '../models/calculation_model.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  final CalculatorLocalDatasource localDatasource;
  bool isDegree;

  CalculatorRepositoryImpl({
    required this.localDatasource,
    this.isDegree = true,
  });

  @override
Future<String> evaluate(String expression) async {
  try {
    // Handle hyperbolic functions manually
    if (expression.contains('sinh(') ||
        expression.contains('cosh(') ||
        expression.contains('tanh(')) {
      return _evaluateHyperbolic(expression);
    }

    // Handle factorial
    if (expression.contains('n!')) {
      return _evaluateFactorial(expression);
    }

    // Handle combinations C(n,r)
    if (expression.contains('C(')) {
      return _evaluateCombination(expression);
    }

    String sanitized = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('π', '3.141592653589793')
        .replaceAll('ln(', 'log(');

    if (isDegree) {
      sanitized = sanitized
          .replaceAll('sinh(', '__SINH__')
          .replaceAll('cosh(', '__COSH__')
          .replaceAll('tanh(', '__TANH__')
          .replaceAll('sin(', 'sin(3.141592653589793/180*')
          .replaceAll('cos(', 'cos(3.141592653589793/180*')
          .replaceAll('tan(', 'tan(3.141592653589793/180*')
          .replaceAll('__SINH__', 'sinh(')
          .replaceAll('__COSH__', 'cosh(')
          .replaceAll('__TANH__', 'tanh(');
    }

    final parser = Parser();
    final exp = parser.parse(sanitized);
    final contextModel = ContextModel();
    final result = exp.evaluate(EvaluationType.REAL, contextModel) as double;

    if (result.isNaN) return 'Error';
    if (result.isInfinite) return 'Cannot divide by zero';

    return CalculatorUtils.formatResult(result);
  } catch (e) {
    return 'Error';
  }
}
  String _evaluateHyperbolic(String expression) {
    try {
      final sinhMatch = RegExp(r'sinh\(([^)]+)\)').firstMatch(expression);
      final coshMatch = RegExp(r'cosh\(([^)]+)\)').firstMatch(expression);
      final tanhMatch = RegExp(r'tanh\(([^)]+)\)').firstMatch(expression);

      if (sinhMatch != null) {
        final value = double.parse(sinhMatch.group(1)!);
        final result = (math.exp(value) - math.exp(-value)) / 2;
        return CalculatorUtils.formatResult(result);
      }
      if (coshMatch != null) {
        final value = double.parse(coshMatch.group(1)!);
        final result = (math.exp(value) + math.exp(-value)) / 2;
        return CalculatorUtils.formatResult(result);
      }
      if (tanhMatch != null) {
        final value = double.parse(tanhMatch.group(1)!);
        final sinh = (math.exp(value) - math.exp(-value)) / 2;
        final cosh = (math.exp(value) + math.exp(-value)) / 2;
        return CalculatorUtils.formatResult(sinh / cosh);
      }
      return 'Error';
    } catch (e) {
      return 'Error';
    }
  }

  String _evaluateFactorial(String expression) {
    try {
      final match = RegExp(r'(\d+)n!').firstMatch(expression);
      if (match != null) {
        final n = int.parse(match.group(1)!);
        int result = 1;
        for (int i = 2; i <= n; i++) {
          result *= i;
        }
        return result.toString();
      }
      return 'Error';
    } catch (e) {
      return 'Error';
    }
  }

  String _evaluateCombination(String expression) {
    try {
      final match = RegExp(r'C\((\d+),(\d+)\)').firstMatch(expression);
      if (match != null) {
        final n = int.parse(match.group(1)!);
        final r = int.parse(match.group(2)!);
        final result = _factorial(n) ~/ (_factorial(r) * _factorial(n - r));
        return result.toString();
      }
      return 'Error';
    } catch (e) {
      return 'Error';
    }
  }

  int _factorial(int n) {
    if (n <= 1) return 1;
    return n * _factorial(n - 1);
  }

  @override
  Future<void> saveCalculation(Calculation calculation) async {
    final model = CalculationModel.fromEntity(calculation);
    await localDatasource.saveCalculation(model);
  }

  @override
  Future<List<Calculation>> getHistory() async {
    final models = await localDatasource.getHistory();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> clearHistory() async {
    await localDatasource.clearHistory();
  }

  @override
  Future<void> deleteCalculation(String id) async {
    await localDatasource.deleteCalculation(id);
  }
  @override
  void setDegreeMode(bool isDegree) {
    this.isDegree = isDegree;
  }
}